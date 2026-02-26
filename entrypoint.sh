#!/bin/bash
eval "$(micromamba shell hook --shell bash)"
micromamba activate bionf_env
exec "$@"
