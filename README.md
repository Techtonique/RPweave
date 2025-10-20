# RPweave

Integrated R + Python + LaTeX document system using [`uv`](https://docs.astral.sh/uv/).

Based on an [`.Rnw`](main.Rnw) (LaTeX Sweave) files. 

For more R packages, modify the [Makefile](Makefile)'s entry `setup`. 

The list of Python packages must be in [requirements.txt](requirements.txt). 

## 📋 **New Paper Workflow**

### **Step 1: Create from Template**

```bash
# Use this repo as a GitHub template, or duplicate it
git clone <your-rpweave-template> new-paper
cd new-paper
```

### **Step 2: Environment Setup**

```bash
# Create and activate Python environment
uv venv venv
source venv/bin/activate

# Install dependencies
make setup

# Verify everything works
make test
```

### **Step 3: Development Cycle**

```bash
# Daily work:
# Write your paper with R/Python code
# Write your paper with R/Python code
# Write your paper with R/Python code
# Write your paper with R/Python code
# Write your paper with R/Python code
make view                   # Build and view PDF
# Repeat editing & make view until done
```

## 🎯 **Perfect Makefile Commands**

Here's how to use the Makefile:

```bash
make        # See all commands
make setup  # One-time setup
make test   # Verify environments
make view   # Build + open PDF (most used)
make clean  # Clean builds
make quick  # Clean + build + view
```

## 📁 **Project Structure for New Papers**
```
new-paper/
├── main.Rnw          # Your paper content (edit this)
├── chunks/           # Modular code
├── data/             # Your datasets
├── outputs/          # Generated figures
├── requirements.txt  # Python dependencies
└── Makefile          # Build system (already perfect)
```

## 🚀 **Quick Start for Collaborators**
```bash
git clone <repo>
cd <repo>
uv venv venv && source venv/bin/activate
make setup
make view
```

## 💡 **Pro Tips for Papers**
1. **Use `make view`** as your primary command during writing
2. **Keep `venv` active** in your terminal session
3. **Version control** your `.Rnw` source, not the PDF
4. **Use chunks/** for long code sections to keep main.Rnw clean
