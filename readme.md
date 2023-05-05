# Delete Commit History
1. #### Remove all history
    ```
    cd <repo you want to remove the history>
    ```

    ```
    rm -rf .git
    ```

2. #### Init a new repo
    ```
    git init
    ```

    ```
    git checkout -b <name of the new master/main branch>
    ```

    ```
    git add .
    ```

    ```
    git commit -m "<commit details>"
    ```

3. #### Push to remote
    ```
    git remote add origin <myrepo link>
    ```

    ```
    git push -u --force origin <name of the new master/main branch>
    ```

[Reference](https://www.willandskill.se/en/articles/deleting-your-git-commit-history-without-removing-repo-on-github-bitbucket)

<br>

# Format USB Stick
```
sudo dd bs=4M if=path/to/archcraft.iso of=/dev/sdX status=progress oflag=sync
```

[Reference](https://wiki.archcraft.io/docs/boot-iso/boot-with-usb)

<br>

# Add Token
- If you already have the repository cloned locally
```
git remote remove origin
git remote add origin https://<TOKEN>@github.com/<REPO-OWNER>/<REPO-NAME>
git push
```

- If you are cloning a new repository
```
git clone https://<TOKEN>@github.com/<REPO-OWNER>/<REPO-NAME>
```

