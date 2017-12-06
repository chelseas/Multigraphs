struct mVertex
    index::Int64
    value::Any    # will be of type string
end

struct mEdge
    index::Int64
    v1::mVertex
    v2::mVertex
    value::Any
end

""" define a simple graph type with vertices and edges that have unique indices
# as well as attributes. 
# Also define an out_edges adjacency list
# and an in_edges adjacency list """    
struct Multigraph
    vertices::Dict{Int64,mVertex}
    edges::Dict{Int64,mEdge}
    out_edges::Dict{Int64,Array{Int64}}
    in_edges::Dict{Int64,Array{Int64}}
end

Multigraph() = Multigraph(Dict(),Dict(),Dict(),Dict())

function add_vertex!(g::Multigraphs.Multigraph, next_ind::Int, value)
    v = mVertex(next_ind, value)
    g.vertices[next_ind] = v # add to vertex list
    g.out_edges[next_ind] = [] # push empty adjacency lists
    g.in_edges[next_ind] = []
    return v
end

function add_vertex!(g::Multigraphs.Multigraph, value)
    next_ind = length(g.vertices) + 1
    return add_vertex!(g, next_ind, value)
end

function add_edge!(g::Multigraphs.Multigraph, v1_ind::Int, v2_ind::Int, value)
    edge_ind = length(g.edges) + 1
    v1 = g.vertices[v1_ind]
    v2 = g.vertices[v2_ind]
    e = mEdge(edge_ind, v1, v2, value)
    g.edges[edge_ind] = e
    push!(g.out_edges[v1_ind], edge_ind)
    push!(g.in_edges[v2_ind], edge_ind)
    return e
end

function remove_edge!(g::Multigraphs.Multigraph, edge::Multigraphs.mEdge)
    delete!(g.edges, edge.index)
    filter!(x->x!=edge.index, g.out_edges[edge.v1])
    filter!(x->x!=edge.index, g.in_edges[edge.v2])
    return g
end

function add_edge!(g::Multigraphs.Multigraph, v1::mVertex, v2::mVertex, value)
    return add_edge!(g, v1.index, v2.index, value)
end

in_degree(g::Multigraphs.Multigraph, v::Multigraphs.mVertex) = length(g.in_edges[v.index])

out_degree(g::Multigraphs.Multigraph,v::Multigraphs.mVertex) = length(g.out_edges[v.index])







