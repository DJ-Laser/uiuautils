┌─╴SortCommand
  ~ "./lib/args.ua" ~ Command CommandDef

  SortDef ← CommandDef CommandDef!(
    OptionDef!([
        OptionDef OptType~Boolean {@r "--reverse"}
      ])
    ArgDef!([Rest])
  )

  Parse ← CommandDef~Parse SortDef

  FileArgs ← ◇Command~Arg~Rest~Values ⊡0 Command~Args
└─╴

SortCommand~Parse &args

⍥({"-"}◌) ⊸≍[] SortCommand~FileArgs

⍆ ≡(⨬(&fo|0◌) ⊸≍□"-")

∧(
  ?
  ⨬(&cl|◌)⊸≍□0 ⤙&rs ∞
  ⊜□ ⊸≠@\n
  ⊂
) ⊙[]

≡&p ⍆
