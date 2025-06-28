┌─╴DirectoryFinder
  ~File {Path IsFile}
  ~Dir {Path Files}
  ~Error {Source Message}
  ~Result {Dirs ← {}|Errors ← {}}

  # File ? Path
  MkFile ↚ (
    File ⟜(⍣&fif0)
  )

  # Result ? Result Dir
  SearchDir ↚ (
    ⍣(⍩(⍜Result~Dirs(⊂) ⊙(□Dir)) ⊙⊙⍚MkFile ⊙⟜&fld
    | ⍜Result~Errors(⊂) ⊙(□Error))
  )

  # Result ? Paths
  Search ← (
    ⊙Result
    ∧(˜SearchDir °□)
  )
└─╴
