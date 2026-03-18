

The term **"Edge"** comes directly from **Graph Theory**, a field of mathematics used to model relationships between objects.

In a network (or "graph"), you have two fundamental components:

1. **Nodes (or Vertices):** The points/objects (the "nouns").
2. **Edges:** The lines connecting them (the "verbs").


Edge vs Relationship vs Cardinality
- edge: the wire (simply says Node A is connected to Node B, existence of link, domain: graph theory / network analysis). It is not a link (UI element), edge = structural data property.
- relationship: electricity (eg Works For, Depends On, Calculates) -- you label an edge w relationship. Not mapping (implies transformation).
- cardinality: quantity (1:1 vs 1:N / 1:M). not a hierarchy, just counts.

---

### 1. It Represents the "Connection"

If a **Node** is a static entity (like a SQL Table), the **Edge** is the active link that tells you *how* it relates to another table. Without the edge, you just have a pile of disconnected data.

### 2. It Allows for "Labeled" Relationships

In a simple hierarchy (like folders), the relationship is always "Parent/Child." But in data modeling, relationships are more complex. Using the term "Edge" allows you to **label** the connection:

* Node A **depends on** Node B.
* Node A **is a synonym for** Node C.
* Node A **is derived from** Node D.

By calling it an "Edge," you are treating the connection as a first-class citizen with its own properties, rather than just a side effect of where a file is saved.

### 3. Directionality

Edges in these systems are usually **Directed Edges** (often called "Arcs").

* In **Lineage**, the edge has an arrow showing data flow from Source $\to$ Target.
* In **Logic**, the edge shows the flow from Premise $\to$ Conclusion.

### Summary Table

| Term | Mathematical Origin | Practical Meaning |
| --- | --- | --- |
| **Node** | Vertex | The "What" (The Page/File) |
| **Edge** | Link / Line | The "How" (The Relationship/YAML link) |

---

**Would you like me to show you how to structure these edges in your Obsidian YAML so they play nicely with plugins like Dataview or Juggl?**