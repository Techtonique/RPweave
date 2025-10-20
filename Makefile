.PHONY: all help clean pdf view setup test env python-setup reset

# Default target - show help
.DEFAULT_GOAL := help

help:
	@echo "RPweave - Integrated R+Python Document System"
	@echo "=============================================="
	@echo ""
	@echo "📁 Project Structure:"
	@echo "  main.Rnw      - Main LaTeX document with R+Python code"
	@echo "  chunks/       - Modular code chunks"
	@echo "  data/         - Data files"
	@echo "  outputs/      - Generated figures and outputs"
	@echo "  venv/         - Python virtual environment"
	@echo ""
	@echo "🚀 Build Commands:"
	@echo "  make pdf      - Build PDF document from main.Rnw"
	@echo "  make view     - Build and open PDF"
	@echo "  make quick    - Clean, build, and view"
	@echo ""
	@echo "⚙️  Setup Commands:"
	@echo "  make setup    - Create Python venv and install dependencies"
	@echo "  make python-setup - Python setup only"
	@echo "  make test     - Test R and Python environments"
	@echo "  make env      - Show environment info"
	@echo ""
	@echo "🧹 Utility Commands:"
	@echo "  make clean    - Remove generated files"
	@echo "  make reset    - Full reset (clean + remove venv)"
	@echo "  make help     - Show this menu"
	@echo ""
	@echo "💡 Quick Start:"
	@echo "  1. make setup    # Set up environments"
	@echo "  2. make test     # Verify setup"
	@echo "  3. make pdf      # Build document"

# Build everything
all: pdf

# Check for highlight
check-highlight:
	@which highlight > /dev/null || echo "⚠️  Install highlight for syntax highlighting: brew install highlight"

pdf: main.Rnw check-highlight
	@echo "📄 Building PDF document..."
	Rscript -e "knitr::knit('main.Rnw', 'main.tex')"
	pdflatex main.tex
	@echo "✅ PDF built: main.pdf"

# Build and view
view: pdf
	@echo "👀 Opening PDF..."
	open main.pdf || xdg-open main.pdf

# Quick rebuild
quick: clean pdf view

# Setup with traditional venv
setup: python-setup
	@echo "📦 Setting up R environment..."
	Rscript -e "\
	pkgs <- c('knitr', 'reticulate', 'ggplot2', 'markdown', 'rmarkdown');\
	to_install <- pkgs[!pkgs %in% installed.packages()[,'Package']];\
	if(length(to_install)) install.packages(to_install, repos='https://cloud.r-project.org');\
	cat('R packages ready:', paste(pkgs, collapse=', '), '\n')\
	"
	@echo "✅ Setup complete!"

# Python setup only
python-setup:
	@echo "🐍 Installing Python packages in the virtual environment..."
	uv pip install -r requirements.txt
	@echo "✅ Python environment ready!"
	@echo "💡 Activate with: source venv/bin/activate"

# Test environments
test:
	@echo "🧪 Testing Environments..."
	@echo ""
	@echo "🐍 Testing Python..."
	@python -c "import pandas as pd; import numpy as np; import matplotlib.pyplot as plt; print('✅ All Python packages loaded')" || echo "❌ Python setup incomplete - run 'make setup'"
	@echo ""
	@echo "📊 Testing R..."
	@Rscript -e "library(knitr); library(reticulate); print('✅ R packages loaded')" || echo "❌ R setup incomplete - run 'make setup'"
	@echo ""
	@echo "🔗 Testing Cross-Language..."
	@Rscript -e "reticulate::use_python('venv/bin/python'); reticulate::py_run_string('print(\"✅ Python from R works\")')" || echo "❌ Cross-language setup incomplete"

# Show environment info
env:
	@echo "🌍 Environment Information:"
	@echo ""
	@echo "🐍 Python:"
	@python --version || echo "Python not available"
	@python -c "import pandas, numpy, matplotlib; print(f'pandas: {pandas.__version__}, numpy: {numpy.__version__}')" || echo "Python packages not available"
	@echo ""
	@echo "📊 R:"
	@Rscript -e "R.version.string" || echo "R not available"
	@Rscript -e "if(require(knitr)) cat('knitr:', packageVersion('knitr'), '\n')" || echo "R packages not available"

# Clean generated files
clean:
	@echo "🧹 Cleaning generated files..."
	rm -f main.tex main.pdf *.aux *.log *.out *.toc *.nav *.snm *.vrb
	rm -rf outputs/*
	@echo "✅ Clean complete"

# Full environment reset
reset: clean
	@echo "🔄 Full environment reset..."
	rm -rf venv/
	@echo "✅ Environment reset - run 'make setup' to reinstall"