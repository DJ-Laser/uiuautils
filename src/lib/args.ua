┌─╴Command
  ~ {Args ← {}|Options ← {}|HasOptionSeparator ← 0|NextOptionName ← []}

  ┌─╴Arg
    |Single {Present ← 0|Value ← []}
    |Rest {Values ← []}
  └─╴

  ┌─╴Option
    ~ {Type Names}

    ┌─╴OptType
      |Boolean {Present ← 0}
      |Occurrences {Occurrences ← 0}
      |Value {Present ← 0|Value ← []}
      |Values {Values ← []}
    └─╴
  └─╴
└─╴

┌─╴CommandDef
  ~ {ArgDefs OptionDefs}

  ┌─╴ArgDef
    |Single
    |Rest
  └─╴

  ┌─╴OptionDef
    ~ {Type Names}

    ┌─╴OptType
      |Boolean
      |Occurrences
      |Value
      |Values
    └─╴
  └─╴

  # Command ? Definition
  GenerateCommand ↚ Command!(
    Command      # Command ?
    ⊙°CommandDef # Command Args Options ? Command Definition 

    ˜°⊸Args ⊙≡◇(
      □⍣(
        ⍩(Arg~Single) °ArgDef~Single
      | ⍩(Arg~Rest) °ArgDef~Rest)
    ) # Command ? Command Args

    ˜°⊸Options ⊙≡(
      OptionDef!(
        (
          ⊸Type #  Type OptionDef ? OptionDef
          ⍣(⍩(Option~OptType~Boolean) °OptType~Boolean
          | ⍩(Option~OptType~Occurrences) °OptType~Occurrences
          | ⍩(Option~OptType~Value) °OptType~Value
          | ⍩(Option~OptType~Values) °OptType~Values
          )
          ⊙OptionDef~Names # Type Names ? Type OptionDef
          Option
        )
      )
    ) # Command  ? Command Options
  )

  # Command ? Command Arg
  AddArg ↚ Command~Arg!(
    ⍜Command~Args(
      ⊚ ⊸≡◇⍣(
        ⟜(⍤⤙◇≍0⊢) # Throws if not Arg~Single
        ⍩(¬Single~Present)
      | (⍤⤙◇≍1⊢) # Throws if not Arg~Rest
        ⍩(1)
      ) # EmptyArgsIndicies Args ? Args

      ⊙⊙⟜&p

      ⍣(⊢ ⊙⊙∘                                                                # Index Args Arg ? Indicies Args Arg
      | ⍩(&exit 2 &ep ◡$"Unexpected argument: `_` Expected _ arguments." ⋅⧻) # ? Indicies Args Arg
      )

      ⊃(⋅⊙∘|⊙⋅⋅∘) °□ ◡⊡

      ⊙⊙□ ⊙⊙⍣(
        ⟜°Single
        ⍩(˜°⊸Single~Value °⊸Single~Present 1)
      | ⟜(⍤⤙◇≍1⊢) # Throws if not Arg~Rest
        ⍩(⍜Rest~Values⊂ ⊙□)
      )

      ⍜⊡◌
    )
  )

  # Command ? Command Option
  AddOption ↚ (
    ⊙◌
  )

  # Command ? Command FlagsString
  AddFlags ↚ (
    ⊙◌
  )

  # Command ? Definition Args
  Parse ← (
    GenerateCommand # Command ? Definition
    ⊙(◌°⊂)          # Command Argv0 ? Command Args

    ˜∧˜◇⍣(
      ⍩(AddArg) °1 ⊸Command~HasOptionSeparator
    | ⍩(°⊸Command~HasOptionSeparator 1) ⊙°"--"
    | ⍩(AddOption) ⊙°$"--_"
    | ⍩(AddFlags) ⊙°$"-_"
    | ⍩(AddArg)
    ) # Command ? Command Arg
  )

└─╴

LsDef ← CommandDef CommandDef!(
  OptionDef!([
      OptionDef OptType~Boolean {@a "--all"}
      OptionDef OptType~Occurrences {@b}
    ])
  ArgDef!([Single Single Rest])
)

CommandDef~Parse LsDef {"args.ua" "1" "2" "--all" "-b" "t" "-ab" "--" "-b" "6"}

## ┌─                                                                                                                                                             
##   ┌─ Args                                                                           │Options                             │∙HasOptionSeparator│NextOptionName   
##     ┌─                        │┌─                        │┌─                        │Type                     │Names     │ 1                 │[]               
##       ∙Single│∙Present│Value  │  ∙Single│∙Present│Value  │  ∙Rest│Values            │∙Boolean│∙Present        │@a│"--all"│                   │                 
##        0     │ 1      │"1"    │   0     │ 1      │"2"    │   1   │["t"│"-b"│"6"]    │ 0      │ 0              │          │                   │                 
##                              ┘│                         ┘│                       ┘  │─────────────────────────┼──────────│                   │                 
##                                                                                    ┘│Type                     │Names     │                   │                 
##                                                                                     │∙Occurrences│∙Occurrences│@b│       │                   │                 
##                                                                                     │ 1          │ 0          │          │                   │                 
##                                                                                                                                                              ┘ 
