# project-skeleton
**NB: this repo (and README) is a work in progress**

This repository is going to serve as a template for LaTeX+R/Python/Julia projects, i.e. projects whose main output is a pdf in which figures, tables, results, etc. are products of scripts written in R, Python, Julia, etc., for example a scientific paper.

This is the next step of [a simple script](https://gist.github.com/janusvm/b48a54353952dc65d153679dedf307c2) that does some of it.
After using it for a project and working on that project, I've come to be dissatisfied with some of the project structure and decided to make a proper repo for maintaining it instead of making changes to the gist.

## Usage
Eventually, when I finish adding stuff to the repo, it will used by

```
git clone https://github.com/janusvm/project-skeleton.git
cd project-skeleton
./init-project.sh
```

## Intended project workflow
Projects initialised with this repo are structured to my personal taste, so it's probably not for everyone.
My workflow with these kinds of projects is:

- Write body of paper in modularised tex document
- Do main analyses in R with custom functionality organised as a package
- Create pdf figures with [ggplot2](https://github.com/tidyverse/ggplot2) in R
- Do certain tasks in other languages (Python, Julia, etc.)
- Compile and run everything with GNU Make for reproducibility
