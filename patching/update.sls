yum-update:
  pkg.uptodate:
    - refresh: true
    - skip_verify: true
    - exclude: 'docker*'