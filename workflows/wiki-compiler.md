---
description: How to ingest project source into the LLM Wiki
---

# Wiki Ingestion Workflow

Use this workflow when you need to "compile" project knowledge or when a new major component is added.

1. **Environmental Audit**:
   - Ensure `lele-brain/projects/{current_project}/wiki/` exists.
   - Project root remains clean (no local `.gitignore` changes needed).

2. **Categorization**:
   - Identify the category: `Architectural`, `Module-Specific`, `External-Integration`, or `Dev-Ops`.

3. **Compilation**:
   - Read the relevant source files.
   - Summarize the "Mental Model" of the code into a new `.md` file in the central wiki folder.
   - Use atomic notes (one concept per file).

4. **Interlinking**:
   - Update the `wiki/README.md` (Index) in the central vault to link to the new note.
   - Add backlinks in related existing notes.

5. **Validation**:
   - Ensure no "Code Trash" or literal copies are in the wiki. It must be a *distillation*.
