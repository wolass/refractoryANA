# Prisma flow diagdramm
require(DiagrammeR)

create_graph() %>%
  add_node(x = -1.2, y = 4,
           label="Records identified through\ndatabase searching\n(n = 150)",
           shape="rectangle",
           width=2,
           height=0.6) %>%
  add_node(x = 1.2, y = 4, label="Additional records idientified\nthrough references\n(n = 18)",
           shape="rectangle",
           width=2.2,
           height=0.6) %>%
  add_node(x = 0, y = 3, label="Records after duplicates removed\n(n = 161)",
           shape="rectangle",
           width=2.5) %>%
  add_node(x = 0, y = 2, label="Records screened\n(n = 161)",
           shape="rectangle",
           width=2) %>%
  add_node(x = 3, y = 2, label="Records excluded\n(n = 115)",
           shape="rectangle",
           width=2) %>%
  add_node(x = 0, y = 1, label="Full-text articles assessed\nfor eligibility\n(n = 46)",
           shape="rectangle",
           width=2,
           height=0.6) %>%
  add_node(x = 3, y = 1, label="Full-text articles excluded\nnon-refractory = 6\nnot a case report = 4\nnot anaphylaxis = 3\nanimal study = 3\nJapanese language = 1",
           shape="rectangle",
           width=2,
           height=1.1) %>%
  add_node(x = 0, y = 0, label="Studies included in\nqualitative synthesis\n(n = 29)",
           shape="rectangle",
           width=2,
           height=0.6) %>%
  add_edge(1,3) %>%
  add_edge(2,3) %>%
  add_edge(3,4) %>%
  add_edge(4,6) %>%
  add_edge(4,5) %>%
  add_edge(6,7) %>%
  add_edge(6,8) %>%
  select_edges() %>%
  add_global_graph_attrs(
    attr = "splines",
    value = "spline",
    attr_type = "graph") %>%
  add_global_graph_attrs(value="black",
                         attr = "fontcolor",
                         attr_type = "node") %>%
  # render_graph() %>%
  export_graph(file_name = "~/Documents/refractoryANA/analysis/figures/prism_flow.png", file_type = "png", title = NULL,
               width = NULL, height = NULL)
