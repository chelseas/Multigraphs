# define a simple graph type with vertices and edges that have unique indices
# as well as attributes. 
# Also define an out_edges adjacency list
# and an in_edges adjacency list

type mVertex
    index::Int64
    value::Any    # will be of type string
end

type mEdge
    index::Int64
    v1::mVertex
    v2::mVertex
    value::Any
end
    
type Multigraph
    vertices::Dict{Int64,mVertex}
    edges::Dict{Int64,mEdge}
    out_edges::Dict{Int64,Array{Int64}}
    in_edges::Dict{Int64,Array{Int64}}
end

Multigraph() = Multigraph(Dict(),Dict(),Dict(),Dict())

function add_vertex!(g, next_ind, value)
    v = mVertex(next_ind, value)
    g.vertices[next_ind] = v # add to vertex list
    g.out_edges[next_ind] = [] # push empty adjacency lists
    g.in_edges[next_ind] = []
    return v
end

function add_vertex!(g, value)
    next_ind = length(g.vertices) + 1
    return add_vertex!(g, next_ind, value)
end

function add_edge!(g, v1_ind::Int64, v2_ind::Int64, value)
    edge_ind = length(g.edges) + 1
    v1 = g.vertices[v1_ind]
    v2 = g.vertices[v2_ind]
    e = mEdge(edge_ind, v1, v2, value)
    g.edges[edge_ind] = e
    push!(g.out_edges[v1_ind], edge_ind)
    push!(g.in_edges[v2_ind], edge_ind)
    return e
end

function add_edge!(g, v1::mVertex, v2::mVertex, value)
    return add_edge!(g, v1.index, v2.index, value)
end

in_degree(g, v) = length(g.in_edges[v.index])

out_degree(g,v) = length(g.out_edges[v.index])
