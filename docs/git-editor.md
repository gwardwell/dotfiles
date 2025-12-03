# Git editor

You can configure Git to use VIM (default) or a text editor/IDE as its edit when authoring commit message, rebasing, or when performing any other editor based action.

## Editing in VIM

1. press `i` (or any other character, it will be ignored) to start editing
2. add/modify the text - **all lines starting with `#` will be ignored**
3. press `esc` to stop editing
4. type `:wq` and press `return` to save and finalize your commit

If you want to abandon your commit when editing:

1. press `esc` to stop editing
2. type `:qa!` and press `return` to quit without saving
3. your commit process will fail because of an empty commit message

## Editing in an IDE

You can configure Git to use the IDE of your choice as its default editor.

### Editing in Visual Studio Code

To configure Git to use Visual Studio Code (VSCode) as its default editor, follow these instructions:

1. add the [VSCode shell command to launch from the command line](https://code.visualstudio.com/docs/setup/mac#_launching-from-the-command-line)
2. run `git config --global core.editor "code -w"` in your terminal app to make Git use VSCode as its editor

Now when you run `git commit`, the process will go like this:

1. type `git commit` in your terminal app
2. a file will open in VSCode containing a copy of your Git commit template for editing
3. Fill out your commit message
4. Save and close the file
5. Your commit will finalize
