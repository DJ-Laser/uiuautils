~ "./lib/directory_finder.ua" ~ DirectoryFinder
~ "./lib/paths.ua" ~ Basename

┌─╴LsCommand
  ~ "./lib/args.ua" ~ Command CommandDef

  LsDef ← CommandDef CommandDef!(
    OptionDef!([
        OptionDef OptType~Boolean {@a "--all"}
      ])
    ArgDef!([Rest])
  )

  Parse ← CommandDef~Parse LsDef

  PathArgs ← ◇Command~Arg~Rest~Values ⊡0 Command~Args
└─╴

LsCommand~Parse &args

DirectoryFinder~Search ⍥(["."]◌) ⊸≍[] ⊸LsCommand~PathArgs

⍚(&ep ˜⍜°$"_: _"(⊃⋅⋅∘⋅⊙◌) °DirectoryFinder~Error) ⊸DirectoryFinder~Result~Errors

DirectoryFinder~Result~Dirs
⟜(⍚⨬("\n"|"") ≡≍0 ⇌⇡⧻)

⍚(
  &p ":" &pf °DirectoryFinder~Dir
  ⍚(&pf " " &pf Basename DirectoryFinder~File~Path)
  &p
)

◌
