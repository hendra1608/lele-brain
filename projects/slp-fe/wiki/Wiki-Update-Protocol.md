# Wiki Update Protocol (PKS)

The **Proactive Knowledge Synchronization (PKS)** is a mandatory protocol for maintaining the "Lele Brain" as the absolute source of truth and token-optimization hub.

## 1. The New File Rule
Whenever a new file is created or encountered (which hasn't been documented), a corresponding wiki entry must be updated or created.
- **Content**: The entry should summarize the file's purpose, key functions/exports, and its relation to other modules.
- **Goal**: Minimize the need to re-open the raw file in future sessions.

## 2. The Implementation Sync Rule
Whenever a raw file is modified, its corresponding wiki node must be updated **immediately** after the code change is verified.
- **Content**: Update the "Technical Implementation" or "Mapping" sections to reflect the new logic.

## 3. Discrepancy Resolution
If during research, the agent finds that the Wiki contradicts the Raw File:
1. Trust the **Raw File**.
2. Fix the **Wiki** node immediately to match the code.
3. Notify the user that a sync has occurred.

## 4. Periodic Indexing
The `README.md` must be updated if new wiki nodes are created to ensure accessibility.

## Related
- [[Token-Optimization-Guide]]
- [[Development-Standards]]
