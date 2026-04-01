#!/usr/bin/env python3
import os
import sqlite3

import requests

# === CONFIG ===
GITHUB_TOKEN = os.environ.get("GITHUB_TOKEN")
NTFY_USERNAME = os.environ.get("NTFY_USERNAME")
NTFY_PASSWORD = os.environ.get("NTFY_PASSWORD")

if not GITHUB_TOKEN:
    raise ValueError("Please set GITHUB_TOKEN as environment variable")

if not NTFY_USERNAME:
    raise ValueError("Please set NTFY_USERNAME as environment variable")

if not NTFY_PASSWORD:
    raise ValueError("Please set NTFY_PASSWORD as environment variable")

USERS = ["enxdev", "alexandrusoare"]  # GitHub usernames to track
NTFY_URL = "https://ntfy.msyavuz.dev/alerts"

# Headers for GitHub API
HEADERS = {"Authorization": f"Bearer {GITHUB_TOKEN}"}

# === DATABASE IN SCRIPT DIRECTORY ===
SCRIPT_DIR = os.path.dirname(os.path.realpath(__file__))
DB_PATH = os.path.join(SCRIPT_DIR, "github_pr_notified.db")
os.makedirs(SCRIPT_DIR, exist_ok=True)

conn = sqlite3.connect(DB_PATH)
c = conn.cursor()
c.execute("""
    CREATE TABLE IF NOT EXISTS notified_prs (
        pr_id TEXT PRIMARY KEY,
        notified_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
    )
""")
conn.commit()


# === FUNCTIONS ===
def send_ntfy_notification(repo, title, url, user):
    message = f"Repo: {repo}\nTitle: {title}\nAuthor: {user}\nLink: {url}"
    requests.post(
        NTFY_URL,
        headers={
            "Title": f"New PR from {user}",
            "Tags": "github,pr,alert",
            "Click": url,
            "Content-Type": "application/x-www-form-urlencoded",
        },
        data=message,
        auth=(NTFY_USERNAME, NTFY_PASSWORD),
    )


def is_pr_notified(pr_id):
    c.execute("SELECT 1 FROM notified_prs WHERE pr_id = ?", (pr_id,))
    return c.fetchone() is not None


def mark_pr_notified(pr_id):
    c.execute("INSERT OR IGNORE INTO notified_prs(pr_id) VALUES(?)", (pr_id,))
    conn.commit()


# === MAIN LOGIC ===
for user in USERS:
    print(f"Checking PRs for user: {user}")

    # GitHub search API: search PRs created by this user since last 24h
    query = f"type:pr+is:open+author:{user}"
    url = f"https://api.github.com/search/issues?q={query}&per_page=100"

    resp = requests.get(url, headers=HEADERS)
    resp.raise_for_status()
    results = resp.json().get("items", [])

    print(f"  Found {len(results)} PRs for {user}")

    for pr in results:
        pr_id = str(pr["id"])
        if is_pr_notified(pr_id):
            continue

        title = pr["title"]
        repo_name = (
            pr["repository_url"].split("/")[-2]
            + "/"
            + pr["repository_url"].split("/")[-1]
        )
        pr_url = pr["html_url"]

        send_ntfy_notification(repo_name, title, pr_url, user)
        mark_pr_notified(pr_id)
        print(f"    Notified PR: {title} in {repo_name}")

conn.close()
