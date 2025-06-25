~ "./lib/args.ua" ~ Command CommandDef

LsDef ← CommandDef CommandDef!(
  OptionDef!([
      OptionDef Type~Boolean {@a "--all"}
    ])
  ArgDef!([Rest])
)

LsDef
