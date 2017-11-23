# Refractory ANA flow diagdramm
require(DiagrammeR)

create_graph() %>%
  add_node(x = 0, y = 0,
           label="Anaphylaxis suspected:\n1. Assess ABC\n2. Inject 300 µg adrenalin i.m.\n3. Call for help",
           shape="rectangle",
           width=2,
           height=0.6) %>%
  add_node(x = 0, y = -1,
           label="1. Venous access\n2. 100% oxygen\n3. Crystalloids i.v\n4. Second dose of adrenalin\n5. H1+H2 Antihistamines i.v.\n6. 125 mg Prednisone i.v.",
           shape="rectangle",
           width=2.2,
           height=1) %>%
  add_node(x = -2, y = -2,
           label="Concomitant beta-blockers?",
           shape="oval",
           width=2.5) %>%
  add_node(x = 0, y = -2, label="Refractory bronchospasm?",
           shape="oval",
           width=2) %>%
  add_node(x = 2, y = -2, label="Refractory hypotension?",
           shape="oval",
           width=2) %>%
  add_node(x = 4, y = -1, label="1. Observation (biphasic reaction)\n2. Adrenalin auto-injector\n3. Allergology consult",
           shape="rectangle",
           width=2,
           height=0.6) %>%
  add_node(x = -2, y = -3, label="consider glucagon infusion",
           shape="rectangle",
           width=2,
           height=0.6) %>%
  add_node(x = 2, y = -3, label="consider vasopressors (dopamine, vasopressine)",
           shape="rectangle",
           width=2,
           height=0.6) %>%
  add_node(x = 0, y = -3, label="consider inhalative beta2-mimetics",
           shape="rectangle",
           width=2,
           height=0.6) %>%
  add_node(x = 4, y = -2, label="Known allergen?",
           shape="oval",
           width=2,
           height=0.6) %>%
  add_node(x = 4, y = -3, label="consider gastric drainage (food)\nsugammadex (rocuronium)\nHaemofiltration (drug)",
           shape="rectangle",
           width=2,
           height=0.6) %>%
  add_edge(1,2) %>%
  add_edge(1,6) %>%
  add_edge(2,3) %>%
  add_edge(2,4) %>%
  add_edge(2,5) %>%
  add_edge(2,6) %>%
  add_edge(3,7) %>%
  add_edge(5,8) %>%
  add_edge(4,9) %>%
  add_edge(10,11) %>%
  add_edge(2,10) %>%
  select_edges() %>%
  add_global_graph_attrs(
    attr = "splines",
    value = "ortho",
    attr_type = "graph") %>%
  render_graph()
  # export_graph(file_name = "~/Documents/refractoryANA/analysis/figures/prism_flow.png", file_type = "png", title = NULL,
  #              width = NULL, height = NULL)
