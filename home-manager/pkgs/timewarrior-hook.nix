{ pkgs, stdenv, ... }:

pkgs.runCommand "patch-on-modify.timewarrior" { } ''
  cp ${pkgs.timewarrior}/share/doc/timew/ext/on-modify.timewarrior $out
  chmod +x $out
  substituteInPlace $out \
   --replace '#!/usr/bin/env python3' '#! ${pkgs.python3}/bin/python'
''
