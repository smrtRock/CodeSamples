# ts-vscode-boilerplate

[![Build Status](https://secure.travis-ci.org/remojansen/ts-vscode-boilerplate.svg?branch=master)](https://travis-ci.org/remojansen/ts-vscode-boilerplate)
[![Dependencies](https://david-dm.org/remojansen/ts-vscode-boilerplate.svg)](https://david-dm.org/remojansen/ts-vscode-boilerplate#info=dependencies)
[![img](https://david-dm.org/remojansen/ts-vscode-boilerplate/dev-status.svg)](https://david-dm.org/remojansen/ts-vscode-boilerplate/#info=devDependencies)
[![img](https://david-dm.org/remojansen/ts-vscode-boilerplate/peer-status.svg)](https://david-dm.org/remojansen/ts-vscode-boilerplate/#info=peerDependenciess)

Boilerplate Visual Studio Code TypeScript project.

Please visit [blog.wolksoftware.com](http://blog.wolksoftware.com/setting-up-your-typescript-vs-code-development-environment) to learn more about this template.

> Note: The article uses TypeScript 1.8 and typings but this repository has been upgraded to TypeScript 2.0 and `@types` type definitions.

# How to use this template?

1) Download `.zip` and unzip it:
```
$ wget https://github.com/remojansen/ts-vscode-boilerplate/archive/master.zip
$ unzip master.zip
```

2) Install dependencies and their type definitions:

> Note: Before running the following commands, make sure you have [Node.js]() installed and 
that you have installed gulp a global package:
>
> ```
> $ npm -g install gulp
> ```

```
$ cd ts-vscode-boilerplate
$ npm install
```

3) Open in VS Code

4) Use `Shift` + `Command` + `p` to open command panel and type "run task":

![](https://raw.githubusercontent.com/remojansen/ts-vscode-boilerplate/master/assets/run-task.png)

5) Select "run task" to see available gulp tasks:

![](https://raw.githubusercontent.com/remojansen/ts-vscode-boilerplate/master/assets/task-list.png)

6) Use `Shift` + `Command` + `=` and select "Start":

![](https://raw.githubusercontent.com/remojansen/ts-vscode-boilerplate/master/assets/enable-wallaby.png)

7) Enjoy real-time tests results powered by [Wallaby.js](http://wallabyjs.com/):
 
![](https://raw.githubusercontent.com/remojansen/ts-vscode-boilerplate/master/assets/wallaby.gif)
 
8) Enjoy coding with TypeScript!

Please send a PR! If you know how to make this template better.
