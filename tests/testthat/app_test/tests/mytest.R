app <- ShinyDriver$new("../")
app$snapshotInit("mytest")

app$snapshot()
app$setInputs(`counter1-antibody` = "IgG")
app$snapshot()
app$setInputs(`counter1-antibody` = "IgA")
app$snapshot()
