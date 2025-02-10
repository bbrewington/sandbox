# Cleaning up a vandalized QR Code

For walkthrough of the logic used to generate this working QR code

## Python environment setup with uv

```bash
cd $(git rev-parse --show-toplevel)
uv init \
  --app \
  --name qr_code_scrub \
  qr_code_scrub
cd qr_code_scrub
source .venv/bin/activate  # On Windows: .venv\Scripts\activate
```

For VS Code, add this path for Python environment (both in editor & for Jupyter Notebook):
`qr_code_scrub/.venv/bin/python`

```bash
uv run ipython kernel install --user --env VIRTUAL_ENV $(pwd)/.venv --name=qr_code_scrub
uv run --with jupyter jupyter lab
# Then, open a notebook in Jupyter Lab in browser.  Select the "qr_code_scrub" kernel
```
