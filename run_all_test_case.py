import requests
import json
import sys
from typing import List, Dict

import os

API_BASE = os.getenv("PISTON_API", "http://144.24.155.203/api/v2")  # public nginx URL
TEST_SNIPPETS = {
    "python": {"language": "python", "version": "3.11.0", "files": [{"name":"main.py","content":"print('hello from Shubham')"}]},
    "javascript": {"language": "javascript", "version": "18.15.0", "files": [{"name":"main.js","content":"console.log('hello from javascript')"}]},
    "dart": {"language":"dart","version":"3.0.1","files":[{"name":"main.dart","content":"void main() { print('hello from dart'); }"}]},
    "java": {"language":"java","version":"15.0.2","files":[{"name":"Main.java","content":"public class Main { public static void main(String[] a){ System.out.println(\"hello from java\"); }}"}]},
}
EXECUTE_PATH = f"{API_BASE}/execute"
RUNTIMES_PATH = f"{API_BASE}/runtimes"

def fetch_runtimes():
    resp = requests.get(RUNTIMES_PATH, timeout=30)
    resp.raise_for_status()
    return resp.json()

def run_for_language(langobj):
    job = {
        "language": langobj["language"],
        "version": langobj["version"],
        "files": langobj["files"],
    }
    r = requests.post(EXECUTE_PATH, json=job, timeout=120)
    return r.status_code, r.json() if r.content else None

def main():
    print("fetch runtimes from public ip", API_BASE)
    runtimes = fetch_runtimes()
    print("available runtimes:", [f"{x['language']}-{x['version']}" for x in runtimes])

    for rt in runtimes:
        lang = rt["language"]
        if lang not in TEST_SNIPPETS:
            print("SKIP:", lang, "no test snippet defined")
            continue
        body = TEST_SNIPPETS[lang]
        # use reported version for safety, in case it differs
        body["version"] = rt["version"]
        print("RUN:", lang, body["version"])
        status, payload = run_for_language(body)
        print("=>", status, json.dumps(payload, indent=2) if payload else "(empty)")
        print("---")

if __name__ == "__main__":
    main()