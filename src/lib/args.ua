┌─╴Command
  ~ {Args ← {}|Options ← {}|HasOptionSeparator ← 0}

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

    ˜°⊸Args ⊙≡(
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

  # Command ? Definition Args
  Parse ← (
    GenerateCommand
    ⍥(.)∞
    ⊙◌
  )

└─╴
