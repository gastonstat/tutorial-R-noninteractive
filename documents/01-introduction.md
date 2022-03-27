Running R non-interactively
================

> ### Learning Objectives:
> 
>   - Invoking and running R from the command line
>   - When to run R non-intereactively
>   - Invoking R from the command line

-----

**Pre-requisites:** This tutorial assumes you are familiar with the
command line and how to navigate your file-system.

-----

## Interactive vs Non-Interactive Sessions

Most people working with R do so in *interactive mode*, either through
RStudio (or another IDE), the console-based GUI, or perhaps R opened
from the command line. In this mode, you type commands, and you get the
outputs in return. In other words, you **interact** with R via its
console, establishing a dialogue between you and R.

Alternatively, you can also execute R in **non-interactive** mode,
sometimes also referred to as *batch mode*. In this case, the
computations are performed by executing scripts via the command
line—without opening an R session.

### Why use non-interactive mode?

Interactive mode is usually the way you want to work when exploring a
dataset for the first time, generating various plots to find the best
visual display, calculating descriptive statistics that summarize the
data, fitting various models to find the most appropriate parameters,
and in general carrying out ad-hoc analyses and playing with new
analysis ideas.

Interactive mode is also useful when you are working in *developer
mode*, that is, writing code for analysis, writing functions, creating
an R package, working on a dynamic document, etc.

As you become more and more familiar with a dataset, and as you advance
in your analysis workflow, you’ll find yourself executing certain tasks
over and over again. For instance, reading a table, subsetting part of
it, calculating some numeric indices, and plotting a handful of
graphics. These type of repetitive actions are good candidates to be
encapsulated in a script that can be run without manual intervention.
For this type of situations you can use R in non-interactive mode.

Another typical situation for switching from interactive to
non-interactive mode is when running simulations. Once the code of your
simulations is ready, you can run the script from the command line,
letting the computer do the work while you work on other tasks (or go
out for a walk, drink a coffee, watch youtube, etc).

Likewise, non-interactive mode is what you probably will be using when
automating your analysis and/or generating reports (e.g. papers, thesis,
dissertation).

### What is an Interactive Session?

Let’s talk a bit about interactive sessions in general, regardless of
the type of program you are using (e.g. R, python, matlab, julia).

Interactive sessions prompt the user for input as data or commands.
Typically, in an interactive session there is a software running on a
computer environment and accepts input from human. This is the simplest
way to work on any system—you enter commands and the software acts to
each entry and then moves on to the next to create a sequence of events.
The interactive session ends when you log off the system.

### What is Batch Processing?

[Batch processing](https://en.wikipedia.org/wiki/Batch_processing), also
known as batch jobs, is the execution of one or more programs on a
computer environment without manual intervention. Batch processing
implies that all data and commands are passed through scripts and/or
command-line parameters and therefore run to completion without human
contact.

The reason why this way of working is known as “batch processing” or
“batch job” is because the input data are collected into batches of
files and are processed in batches by the program. Often, batch jobs are
submitted to a job scheduler and run on the first available compute
node(s).

-----

## How to Run R in Non-Interactive mode?

R can be run in non-interactive mode in several ways. All of them
involve working from the command line or some terminal emulator. In Mac
systems, you use the **terminal**. In Windows systems you use the
**command prompt**, or *PowerShell*, or any other shell alternative
(e.g. GitBash, Cygwin).

Assuming that you have an R script file `myscript.R` that will be
executed non-interactively, you can use one of the following options:

``` bash
# Using 'R CMD BATCH' 
R CMD BATCH myscript.R

# Using 'Rscript'
Rscript myscript.R

# Using input redirection
R < myscript.R

# Running a shell script
./myscript.R
```

Each of these options are discussed in more detail in this tutorial. In
this introduction, we will discuss some considerations about using and
running scripts in a non-interactive way.

### Motivation

Consider a stats professor that has a dataset with the information of a
gradebook in one of her classes. For instance, the gradebook has
variables for attendance, homework assignments, tests, and grade. Here’s
what the data table could look like:

| id | attend | hw     | test1 | test2 | test3 | grade |
| -- | ------ | ------ | ----- | ----- | ----- | ----- |
| 1  | 36.84  | 25.00  | 70.00 | 10.00 | 32.65 | F     |
| 2  | 84.21  | 87.50  | 58.00 | 49.00 | 64.56 | D     |
| 3  | 94.74  | 100.00 | 86.00 | 88.00 | 90.90 | A     |
| 4  | 89.47  | 100.00 | 94.00 | 90.00 | 93.79 | A     |
| 5  | 94.74  | 100.00 | 54.00 | 18.00 | 56.90 | F     |

The first time she explores the data, she will do so in interactive
mode. Let’s say she already identified a couple of variables of
interest. Likewise, she has generated dozens of plots and finally
decided to keep one histogram, one barplot, and one scatter diagram. The
professor will have to generate those plots on a regular basis, maybe
every week or every time after a test has taken place.

The professor has an R script `tests_histograms.R` that reads in the
dataset containing the gradebook scores, selects the variables of the
test scores, and plots histograms for each test; something like this:

``` r
# script to generate histograms of test's
dat <- read.csv('gradebook.csv')

test_columns <- grep('test', names(dat))

for (i in seq_along(test_columns)) {
    png(paste0('histogram_test', i))
    hist(dat[ ,i], main = paste('Test', names(dat)[i]))
    dev.off()
}
```

Each time the professor needs a report, she could open RStudio, run the
script from within RStudio, and get the plots. This is a repetitive task
that can be automated. It would be better not to have to open RStudio,
avoiding to manually run pieces of the script everytime.

How can she “automate” this task? One way to run this script wihtout
opening an interactive session, is using the `Rscript` command via the
command line:

``` bash
Rscript -e 'tests_histograms.R'
```

This is much more efficient and convenient. We will discuss more options
to run scripts non-interactively in the next sections of the tutorial.

-----

### Windows and the command prompt

In Windows you can find the program `Command prompt` by clicking the
`Start` button and selecting `All programs - Accessories`. After
clicking on the `Command prompt` icon a new window will pop-up and you
can start writing commands.

When you install R on Windows, it comes with the `R.exe` file, which is
an executable that will invoke R from the command line. However, if you
type `R` in your command prompt, chances are that you will get an error
message telling you that `R` is not a recognized command.

Although R is installed on your computer, the system is not able to find
the `R.exe` file. What happens is that `R.exe` is in a directory that is
not part of the *default search path* of Windows. To solve this problem
you have to change the search path so that it includes the path to the
directory where `R.exe` is. To do so follow these steps:

1.  Open the *Control Panel*, choose `System`, click on `Advanced system
    settings` in the menue to the left and choose the `Environment
    variables` button.

2.  Choose the variable `Path` and click on the `Edit–button`. Now you
    have to edit `Variable value` so that it also contains the path to
    the directory where the various R binaries (programs) are installed.

3.  The path to this file is found in Windows explorer by looking for
    the directories were R was installed. Typically the path is
    something like `C:\Program Files\R\R-2.15.1\bin\x64` and it should
    be appended to the already existing path in `Variable value`.

4.  Note that the various paths in the search path as separated with a
    semi–colon so you should add an initial `;` to the string characters
    that you append to `Variable value`.

In addition to `R.exe`, there are also two more versions: `Rcmd.exe` and
`Rscript.exe`.

### Mac and command line

In Mac, you can find the *terminal* under the `Utilities` folder which
is inside the `Applications` folder. If you are using the *Finder*,
click on the folder `Applications`, and then click on `Utilities`. There
you should be able to find a black screen icon called **Terminal**.
Click on it and you will have a new window opened where you can start
typing commands.

Type `R` in the terminal to make sure that the systems knows where R is
located.

-----
