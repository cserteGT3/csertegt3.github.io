@def title = "Contribute to Julia packages"

This is a really short guide on how to contribute to a Julia package.

## Contribute to a community package

1. Fork the original repository (probably the `#master` branch).
2. You may create a separate Julia environment for the project (see below).
3. Clone your forked repo: `(activeProject) pkg> dev "link-to-your-forked-repo"`. It will show it's directory, which is a proper git clone of the repo. It will be something like `C:\Users\cstamas\.julia\dev`.
4. Modify the files as you want, commit the changes.
5. When you're ready, create a pull request on GitHub.
6. You can undo the `dev` command with `free`.
