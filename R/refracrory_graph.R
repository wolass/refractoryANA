# Refractory ANA flow diagdramm
require(DiagrammeR)

create_graph() %>%
  add_node(x = 0, y = 0,
           label="Anaphylaxis suspected:\n1. Assess ABC\n2. Inject adrenaline i.m.",
           shape="rectangle",
           width=2.2,
           height=0.6) %>%
  add_node(x = 0, y = -1,
           label="No response:\n1. i.v. line and volume replacement\n2. 100% oxygen\n3. Second dose of adrenaline\n4. H1+H2 Antihistamines i.v.\n5. Corticosteroids i.v.",
           shape="rectangle",
           width=3,
           height=1.1) %>%
  add_node(x = -2.5, y = -2,
           label="Concomitant beta-blockers?",
           shape="oval",
           width=2.5) %>%
  add_node(x = 0, y = -2, label="Refractory bronchospasm?",
           shape="oval",
           width=2.2) %>%
  add_node(x = 2.5, y = -2, label="Refractory hypotension?",
           shape="oval",
           width=2.5) %>%
  add_node(x = 4, y = -0.4, label="Good clinical response:\n1. Observation (biphasic reaction)\n2. Adrenalin auto-injector\n3. Allergology consult",
           shape="rectangle",
           width=2.5,
           height=0.8) %>%
  add_node(x = -2.5, y = -3, label="consider glucagon infusion",
           shape="rectangle",
           width=2,
           height=0.6) %>%
  add_node(x = 2.5, y = -3, label="consider vasopressors\n(norepinephrine, vasopressin)\nand methylene blue",
           shape="rectangle",
           width=2.3,
           height=0.6) %>%
  add_node(x = 0, y = -3, label="consider inhalative\n beta2-mimetics",
           shape="rectangle",
           width=2,
           height=0.6) %>%
  add_node(x = 5, y = -2, label="Known allergen?",
           shape="oval",
           width=2,
           height=0.6) %>%
  add_node(x = 5, y = -3, label="consider: gastric drainage (food),\nsugammadex (rocuronium),\nHaemofiltration (drug),",
           shape="rectangle",
           width=2.5,
           height=0.6) %>%
  add_node(x = 1, y = -4, label="No response:\nConsider: extracorporeal life support (CPB or ECMO)\n1. Gain time in dealing with life-threathening symptoms,\n2. Eliminate exposure to a possible (occluded) elicitor",
           shape="rectangle",
           width=8,
           height=0.8) %>%
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
  add_edge(7,12) %>%
  add_edge(8,12) %>%
  add_edge(9,12) %>%
  add_edge(11,12) %>%
  select_edges() %>%
  add_global_graph_attrs(
    attr = "fontcolor",
    value = "black",
    attr_type = "graph") %>%
  add_global_graph_attrs(
    attr = "splines",
    value = "ortho",
    attr_type = "graph") %>%
   # render_graph()
  export_graph(file_name = "~/Documents/refractoryANA/analysis/figures/algo.png", file_type = "png", title = NULL,
                width = NULL, height = NULL)
