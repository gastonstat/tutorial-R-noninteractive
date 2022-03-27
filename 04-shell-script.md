Shell Rscript
================

> ### Learning Objectives:
> 
>   - Invoking and running R scripts as shell scripts
>   - Review of shell scripts
>   - Execute some scripts

-----

## Shell Scripts

A shell script is simply a text file that contains a series of shell
commands that you want to run in sequence.

I’ll show you an example of a simple shell script, and then I will
describe how to write a shell script for R.

For this example I’m assuming that you are working with the
[bash](https://en.wikipedia.org/wiki/Bash_\(Unix_shell\)) shell.

This example is based on the file `today.sh`, which is available in the
`scripts/` folder of this tutorial. If you look at the contents of
`today.sh` you should see the following lines:

``` bash
#!/bin/bash

echo "The current time and day is"
date
```

Basically, `today.sh` is a script that prints a message and the
current’s date information.

When creating a shell script file, you must specify the shell you are
using in the first line of the file. In this case we have:
`#!/bin/bash`. Typically the pound sign `#` is used as a comment line.
However, the first line of a shell script file is a special case. The
set of characters `#!` is often referred to as the **shebang**. The
shebang tells the shell what shell to run the script under (`bash` in
this example).

If you try to run the file by simply typing its name on the command
line, you will be disappointed:

``` bash
today.sh
-bash: today.sh: command not found
```

Even though `today.sh` is declared as a file that the bash should
execute, the error message indicates that `bash` is not able to find the
command.

This issue has to do with the way the `bash` shell finds commands.
`bash` uses an environment variable called `PATH` to find commands. The
`PATH` variable is set to look for commands only in a handful of
directories. To get the shell to find the `today.sh` script, you have
two options:

  - Add the directory where your shell script file is located to the
    `PATH`.

  - Use an absolute or relative file path to reference your shell
    script.

We’ll choose the second option, by referencing the file in the
`scripts/` directory using the dot operator:

``` bash
./today.sh
-bash: ./today.sh: Permission denied
```

Even though the shell did find the script, there’s still a problem: we
don’t have permission to execute the file. This can be solved quickly by
changing the permissions with the `chmod` command:

``` bash
chmod u+x today.sh
```

Now you should be able to run `today.sh` without problems:

``` bash
./today.sh
```

-----

## R shell scripts

Now that we’ve seen how to write a shell script file, we can discuss how
to do something similar with an R script.

Running R from a shell script involves writing a shell script including
R functions and then calls to these functions. For instance, consider
the file `hello` in the `scripts/` directory:

``` bash
#!/usr/bin/env Rscript
hello_world <- function(){
   cat('hi! I'm an R script\n')
}

hello_world()
```

This script calls the function `hello_world()` which prints a dummy
message. The important thing is the first line of the file containing
the shebang and telling the shell where to find the program
(i.e. `Rscript`) to run the script: `#!/usr/bin/env Rscript`.

The next step is to change the permissions of the file to make it
executable:

``` bash
chmod u+x hello
```

Assuming that `hello` is in your current directory, you can run it like
so:

``` bash
./hello
```

### Example: Area of Rectangle

The file `area.txt` in the `scripts/` folder is another shell script
that calculates the area of rectangle of length 3 and width 5:

``` bash
#!/usr/bin/env Rscript

len <- 3
width <- 5
area <- len * width

cat("Area of a rectangle:\n")
cat("length = ", len, "\n")
cat("width  = ", width, "\n")
cat("area   = ", area, "\n")
```

After changing the permission of the file:

``` bash
chmod u+x area.txt
```

you can execute it like this:

``` bash
./area.txt
```

    Area of a rectangle:
    length =  3 
    width  =  5 
    area   =  15 

-----

## Passing arguments

If you want to pass arguments to your script, remember to use the
function `commandArgs(trailingOnly = TRUE)`. Here’s the same example
presented in the third section `03-script`, although in this case the
script file is called `normal-vector.txt`:

``` bash
#!/usr/bin/env Rscript

# Generates a random vector following a normal distribution.
# Values for 'n', 'mean', 'sd' are expected (in that order).

# reading arguments ('n', 'mean', 'sd')
args <- commandArgs(trailingOnly = TRUE)

n <- as.numeric(args[1])
mean <- as.numeric(args[2])
sd <- as.numeric(args[3])

x <- rnorm(n, mean, sd)
cat(x, '\n')
```

Assuming that you change the file permissions, you can run it as:

``` bash
./normal-vector.txt 10 5 1
```

    4.622793 3.62027 4.268408 5.323577 6.735752 6.647538 7.315079 5.048416 5.460435 7.244645 

-----

### Bash R script

Here’s one more example, slightly different. In this case we have a
`bash` script that instead of using the command `Script`, it uses the
`R` command. The file is `bash-example.sh`

``` bash
#!/bin/bash

# creates a csv file with log-transformed
# variable 'mpg' and 'hp' from data set 'mtcars'

R --slave <<EOF
log_mtcars <- function()
{
    log_mpg <- log(mtcars$mpg)
    log_hp <- log(mtcars$hp)
    logdata <- data.frame(log_mpg, log_hp)
    write.csv(logdata, "log-mtcars.csv")
}

log_mtcars()

EOF
```

Now, make this file executable by

``` bash
chmod +x bash-example.sh
```

To run the R function included in this file type

``` bash
./bash-example.sh
```

-----
