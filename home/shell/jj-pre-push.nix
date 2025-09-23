{
  lib,
  python3,
  fetchFromGitHub,
}:

python3.pkgs.buildPythonApplication rec {
  pname = "jj-pre-push";
  version = "0.2.1";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "acarapetis";
    repo = "jj-pre-push";
    rev = "v${version}";
    hash = "sha256-9HyVWxYmemF/K3ttQ0L1lZF/XFkSeqwli/Mm+FFI8lQ=";
  };

  build-system = [
    python3.pkgs.uv-build
  ];

  dependencies = with python3.pkgs; [
    typer-slim
  ];

  pythonImportsCheck = [
    "jj_pre_push"
  ];

  meta = {
    description = "Run pre-commit.com before `jj git push";
    homepage = "https://github.com/acarapetis/jj-pre-push";
    license = lib.licenses.asl20;
    maintainers = with lib.maintainers; [ xanderio ];
    mainProgram = "jj-pre-push";
  };
}

