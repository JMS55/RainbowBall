extends MeshInstance

export(int) var size
var pickup_scene = preload("res://Scenes/Pickup.tscn")
var light_scene = preload("res://Scenes/Light.tscn")

func _ready():
    var half_size = self.size / 2.0

    var st = SurfaceTool.new()
    st.begin(Mesh.PRIMITIVE_TRIANGLES)

    var rng = RandomNumberGenerator.new()
    randomize()
    var noise = OpenSimplexNoise.new()
    noise.seed = randi()
    noise.octaves = 1
    noise.period = 8.0

    for x in range(self.size + 1):
        for z in range(self.size + 1):
            var y = (noise.get_noise_2d(x, z) + 1.0) * 3.0
            if x == 0 || z == 0 || x == self.size || z == self.size:
                y = 40.0
            st.add_vertex(Vector3(x - half_size, y, z - half_size))

            if x > 2 && z > 2 && x < self.size - 2 && z < self.size - 2:
                if rng.randf() <= (1.0 / 75.0):
                    var pickup = pickup_scene.instance()
                    pickup.transform.origin = Vector3(x - half_size, y + 0.5, z - half_size)
                    self.add_child(pickup)

    for row in range(self.size):
        for col in range(self.size):
            var top_left_corner = row * (self.size + 1) + col
            var top_right_corner = top_left_corner + 1

            st.add_index(top_right_corner + self.size + 1)
            st.add_index(top_right_corner)
            st.add_index(top_left_corner)

            st.add_index(top_left_corner + self.size + 1)
            st.add_index(top_right_corner + self.size + 1)
            st.add_index(top_left_corner)

    st.generate_normals()
    self.mesh = st.commit()

    $StaticBody/CollisionShape.shape = self.mesh.create_trimesh_shape()

    for xz in [ [0.0, 0.0],
                [self.size / 2.0, self.size / 2.0],
                [self.size / 2.0, self.size / -2.0],
                [self.size / -2.0, self.size / 2.0],
                [self.size / -2.0, self.size / -2.0] ]:
        var light = light_scene.instance();
        light.transform.origin.x = xz[0]
        light.transform.origin.z = xz[1]
        self.add_child(light)
