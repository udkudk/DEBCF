# README for DEBCF: Dynamic Event Booting &amp; Configuration Framework

> [!NOTE]
> This is a **Markdown** file and is formatted for viewing in $$\textcolor{Gold}{Github}$$. VS Code Markdown Viewer Extensions give some errors (such as 'LATEX' text Color Codes giving some errors)
> You can read the [Markdown Wiki](#markdown-wiki) to learn how to use and modify these types of files.
> This Documentation is for $$\textcolor{aqua}{Stellaris}$$ game, $$\textcolor{Gold}{DEBCF: Dynamic Event Booting \& Configuration Framework}$$ mod.
<!--Horizontal Line-->
---


# Markdown Wiki

## Text Color Changing in Github

> [!TIP]
> Normally Github doesn't permit Text Color changes in README files. We use a workaround by using Inline Coding from LATEX programming language.

> [!WARNING]
> Viewing Color Text Codes in VSCode gives some formatting errors. View them in Github.

You can change Text Color in anywhere in your Markdown files. Even titles.

You can use either ```\textcolor```, or ```\color``` codes to do the job. ```\textcolor``` only impacts the Text, while ```\color``` is applied to text, all math symbols, and equations.

- The correct Syntax is `{\color{color-name}<text or equation>}`
- Each `\color{color-name}` should be under separate one open `{` and one closed `}` curly bracket.
- While using multiple words etc, you need to use `\space` function to leave spaces between words.
- To use Special Characters, you need to escape them via `\`. e.g. `\&` >> &
- To prevent the Text from appearing in Middle of Screen, you should use a `&nbsp;` to leave a Space that LATEX can't ignore.

```
$$\textcolor{red}{Welcome} \space \textcolor{lightblue}{To } \space \textcolor{lightgreen}{Github}$$
```

Usage:

Multiple Colors & Spaces:
```
$$\textcolor{aqua}{Example}$$
```
$$\textcolor{aqua}{Color Example}$$

Singular Color:
```
$$\textcolor{aqua}{Example \space with \space only \space 1 \space Color}$$
```
&nbsp; $$\textcolor{aqua}{Example \space with \space only \space 1 \space Color}$$


$$\textcolor{aqua}{Color Example}$$
$$\textcolor{red}{Color Example}$$
$$\textcolor{gold}{Color Example}$$
$$\textcolor{lightblue}{Color Example}$$
$$\textcolor{lightgreen}{Color Example}$$

