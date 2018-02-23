#pathofiz diagdramm
require(DiagrammeR)

create_graph() %>%
  add_node(x = -2.8, y = -1,
           label="Impaired right\nventricular function",
           shape="rectangle",
           width=2.2,
           height=0.6) %>%
  add_node(x = -2.8, y = -2, label="Coronary artery disease",
           shape="rectangle",
           width=2.2,
           height=0.6) %>%
  add_node(x = 0, y = -2, label="Failure to restore\nsufficient cardiac output",
           shape="rectangle",
           width=2.5) %>%
  add_node(x = 0, y = -3, label="Insufficient tissue perfusion",
           shape="rectangle",
           width=2) %>%
  add_node(x = 0, y = -4, label="Multiorgan failure",
           shape="rectangle",
           width=2) %>%
  add_node(x = 3, y = -4, label="Concomitant beta-blockers",
           shape="rectangle",
           width=2.2,
           height=0.6) %>%
  add_node(x = 3, y = -3, label="Insufficient volume\nresubstitution, vasopression",
           shape="rectangle",
           width=2.2,
           height=0.8) %>%
  add_node(x = 0, y = 0, label="Persistent allergen contact",
           shape="rectangle",
           width=2,
           height=0.6) %>%
  add_node(x = 0, y = -1, label="Prolonged vasodialation",
           shape="rectangle",
           width=2,
           height=0.6) %>%
  add_node(x = 3, y = 0, label="Iatrogenic factors",
           shape="plaintext",
           width=2,
           height=0.6) %>%
  add_node(x = -2.8, y = 0, label="Patient dependent\n factors",
           shape="plaintext",
           width=2,
           height=0.6) %>%
  add_node(x = -2.8, y = -3, label="Older age",
           shape="rectangle",
           width=2.2,
           height=0.6) %>%
  add_node(x = 3, y = -2, label="Late epinephrine injection",
           shape="rectangle",
           width=2.2,
           height=0.6) %>%
  add_node(x = 3, y = -1, label="Failure to cease\nallergen exposition",
           shape="rectangle",
           width=2.2,
           height=0.6) %>%
  add_node(x = -2.8, y = -4, label="Bronchial\nhyperresponsiveness",
           shape="rectangle",
           width=2.2,
           height=0.6) %>%
  add_edge(8,9) %>%
  add_edge(9,3) %>%
  add_edge(3,4) %>%
  add_edge(6,3) %>%
  add_edge(4,5) %>%
  add_edge(1,3) %>%
  add_edge(2,3) %>%
  add_edge(7,3) %>%
  add_edge(12,3) %>%
  add_edge(13,9) %>%
  add_edge(14,9) %>%
  add_edge(15,4) %>%
  # select_edges() %>%
  add_global_graph_attrs(
    attr = "splines",
    value = "ortho",
    attr_type = "graph") %>%
  add_global_graph_attrs(value="black",
                         attr = "fontcolor",
                         attr_type = "node") %>%
  # render_graph()
  export_graph(file_name = "~/Documents/refractoryANA/analysis/figures/pato.png", file_type = "png", title = NULL,
               width = NULL, height = NULL)
