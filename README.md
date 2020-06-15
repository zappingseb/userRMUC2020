# userRMUC2020
Why continuous integration will save jour team and your packages

Imagine we have a use-case that is important for people's life. A new drug should go to the market or not. Does it decreate people's Antibody level or not. Two studies were pointed out. One checking IgG Antibody levels, and one checking out IgA antibody levels.

Now we want to make sure, that:

1. Summary values are caluculated right
2. A summary plot is shown right
3. Upon a user selecting "IgG" in a shiny-app, he get's the IgG Table and Plot, and upon selecting "IgA" he gets the same values for "IgA"

So normally you would create:

1) A script that runs the table and the plot
2) An app that you can execute to see both. Hopefully the app already contains a shiny-module.

Now imagine your team continuing to develop the summary table and adding new features to it. You still want:

1. The summary values to be right
2. The plot to work
3. The app to work right

How would you enable this? Anytime your co-worker changes the script you would test it? Would you see if he changes quantile levels or renames the inputIDs of the shiny app each time? Maybe not.

There are three things that will make it way easier to collaborate:

1. Version control in e.g. Github
2. Wrapping your code into an R-package with tests
3. Allow changes to version control only upon passing all tests inside a designated environment

Today I want to talk only about **3**. Automatically running checks and tests in a designated environment is what **CI/CD** systems do

