using Multigraphs
using Base.Test

# write your own tests here
@test 1 == 1

g = Multigraph()
v1 = add_vertex!(g, "hi")
v2 = add_vertex!(g, "bye")
add_edge!(g, v1, v2, "dog")

# loop through vertices
for v in values(g.vertices)
    println(v)
    @test v.value in ["hi", "bye"]
end

# loop through edges
for e in values(g.edges)
    println(e)
    @test e.value == "dog"
end

# get out degree
for v in values(g.vertices)
    println("outdegree of vertex ",v.index," is: ", out_degree(g,v))
    if v.value == "hi"
        @test out_degree(g,v) == 1
    elseif v.value == "bye"
	@test out_degree(g,v) == 0
    end
end

# get in degree
for v in values(g.vertices)
    println("indegree of vertex ",v.index," is: ", in_degree(g,v))
    if v.value == "hi"
        @test in_degree(g,v) == 0
    elseif v.value == "bye"
        @test in_degree(g,v) == 1
    end
end

# iterate over out edges
for v in values(g.vertices)
    for e_ind in g.out_edges[v.index]
        print("Edge ",e_ind,": ",g.edges[e_ind])
        println(" connects ", v," and ", g.edges[e_ind].v2)
        @test v == g.edges[e_ind].v1
        @test g.edges[e_ind].v2.value == "bye"
    end
end

# iterate over in edges
for v in values(g.vertices)
    for e_ind in g.in_edges[v.index]
        print("Edge ",e_ind,": ",g.edges[e_ind])
        println(" connects ", g.edges[e_ind].v1," and ", v)
        @test v == g.edges[e_ind].v2
        @test g.edges[e_ind].v1.value == "hi"
    end
end
