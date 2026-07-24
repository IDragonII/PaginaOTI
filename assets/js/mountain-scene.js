/**
 * GenerativeMountainScene - Wireframe grid with animated vertex dots
 * Light cyan (#e0f7fa) on dark background, gentle flowing waves
 * Points share the same vertex shader displacement as the wireframe
 */
function initMountainScene(container) {
  if (!container || typeof THREE === 'undefined') return;

  var scene = new THREE.Scene();

  var camera = new THREE.PerspectiveCamera(
    75,
    container.clientWidth / container.clientHeight,
    0.1,
    100
  );
  camera.position.set(0, 1.5, 3);
  camera.rotation.x = -0.3;

  var renderer = new THREE.WebGLRenderer({ antialias: true, alpha: true });
  renderer.setSize(container.clientWidth, container.clientHeight);
  renderer.setPixelRatio(Math.min(window.devicePixelRatio, 2));
  container.appendChild(renderer.domElement);

  var geometry = new THREE.PlaneGeometry(12, 8, 80, 80);

  // Shared vertex shader — Perlin noise displacement
  var vertexShader = [
    'uniform float time;',
    'varying vec2 vUv;',
    'varying float vDist;',
    '',
    'vec3 mod289(vec3 x) { return x - floor(x * (1.0 / 289.0)) * 289.0; }',
    'vec4 mod289(vec4 x) { return x - floor(x * (1.0 / 289.0)) * 289.0; }',
    'vec4 permute(vec4 x) { return mod289(((x*34.0)+1.0)*x); }',
    'vec4 taylorInvSqrt(vec4 r) { return 1.79284291400159 - 0.85373472095314 * r; }',
    'float snoise(vec3 v) {',
    '    const vec2 C = vec2(1.0/6.0, 1.0/3.0);',
    '    const vec4 D = vec4(0.0, 0.5, 1.0, 2.0);',
    '    vec3 i = floor(v + dot(v, C.yyy));',
    '    vec3 x0 = v - i + dot(i, C.xxx);',
    '    vec3 g = step(x0.yzx, x0.xyz);',
    '    vec3 l = 1.0 - g;',
    '    vec3 i1 = min(g.xyz, l.zxy);',
    '    vec3 i2 = max(g.xyz, l.zxy);',
    '    vec3 x1 = x0 - i1 + C.xxx;',
    '    vec3 x2 = x0 - i2 + C.yyy;',
    '    vec3 x3 = x0 - D.yyy;',
    '    i = mod289(i);',
    '    vec4 p = permute(permute(permute(',
    '              i.z + vec4(0.0, i1.z, i2.z, 1.0))',
    '            + i.y + vec4(0.0, i1.y, i2.y, 1.0))',
    '            + i.x + vec4(0.0, i1.x, i2.x, 1.0));',
    '    float n_ = 0.142857142857;',
    '    vec3 ns = n_ * D.wyz - D.xzx;',
    '    vec4 j = p - 49.0 * floor(p * ns.z * ns.z);',
    '    vec4 x_ = floor(j * ns.z);',
    '    vec4 y_ = floor(j - 7.0 * x_);',
    '    vec4 x = x_ * ns.x + ns.yyyy;',
    '    vec4 y = y_ * ns.x + ns.yyyy;',
    '    vec4 h = 1.0 - abs(x) - abs(y);',
    '    vec4 b0 = vec4(x.xy, y.xy);',
    '    vec4 b1 = vec4(x.zw, y.zw);',
    '    vec4 s0 = floor(b0) * 2.0 + 1.0;',
    '    vec4 s1 = floor(b1) * 2.0 + 1.0;',
    '    vec4 sh = -step(h, vec4(0.0));',
    '    vec4 a0 = b0.xzyw + s0.xzyw * sh.xxyy;',
    '    vec4 a1 = b1.xzyw + s1.xzyw * sh.zzww;',
    '    vec3 p0 = vec3(a0.xy, h.x);',
    '    vec3 p1 = vec3(a0.zw, h.y);',
    '    vec3 p2 = vec3(a1.xy, h.z);',
    '    vec3 p3 = vec3(a1.zw, h.w);',
    '    vec4 norm = taylorInvSqrt(vec4(dot(p0, p0), dot(p1, p1), dot(p2, p2), dot(p3, p3)));',
    '    p0 *= norm.x; p1 *= norm.y; p2 *= norm.z; p3 *= norm.w;',
    '    vec4 m = max(0.6 - vec4(dot(x0, x0), dot(x1, x1), dot(x2, x2), dot(x3, x3)), 0.0);',
    '    m = m * m;',
    '    return 42.0 * dot(m * m, vec4(dot(p0, x0), dot(p1, x1), dot(p2, x2), dot(p3, x3)));',
    '}',
    '',
    'void main() {',
    '    vUv = uv;',
    '    float noiseFreq = 0.6;',
    '    float noiseAmp = 0.3;',
    '    float displacement = snoise(vec3(position.x * noiseFreq, position.y * noiseFreq - time * 0.15, 0.0)) * noiseAmp;',
    '    displacement += snoise(vec3(position.x * noiseFreq * 1.8, position.y * noiseFreq * 1.8 - time * 0.15, 0.0)) * (noiseAmp * 0.4);',
    '    vec3 newPosition = position + normal * displacement;',
    '    vec2 center = vec2(0.5, 0.5);',
    '    vDist = 1.0 - smoothstep(0.0, 0.6, distance(uv, center));',
    '    gl_Position = projectionMatrix * modelViewMatrix * vec4(newPosition, 1.0);',
    '}'
  ].join('\n');

  // Wireframe grid material
  var material = new THREE.ShaderMaterial({
    side: THREE.DoubleSide,
    wireframe: true,
    uniforms: {
      time: { value: 0 },
      color: { value: new THREE.Color("#e0f7fa") },
    },
    vertexShader: vertexShader,
    fragmentShader: [
      'uniform vec3 color;',
      'varying vec2 vUv;',
      'varying float vDist;',
      '',
      'void main() {',
      '    float alpha = vDist * 0.7;',
      '    gl_FragColor = vec4(color, alpha);',
      '}'
    ].join('\n'),
    transparent: true,
  });

  var mesh = new THREE.Mesh(geometry, material);
  mesh.rotation.x = -Math.PI / 2;
  scene.add(mesh);

  // Points at vertices — same vertex shader displacement as wireframe
  var pointsMaterial = new THREE.ShaderMaterial({
    uniforms: {
      time: { value: 0 },
      color: { value: new THREE.Color("#e0f7fa") },
      pointSize: { value: 3.0 },
    },
    vertexShader: vertexShader,
    fragmentShader: [
      'uniform vec3 color;',
      'uniform float pointSize;',
      'varying float vDist;',
      '',
      'void main() {',
      '    vec2 uv = gl_PointCoord - vec2(0.5);',
      '    float d = length(uv);',
      '    if (d > 0.5) discard;',
      '    float alpha = smoothstep(0.5, 0.15, d) * vDist * 0.9;',
      '    gl_FragColor = vec4(color, alpha);',
      '}'
    ].join('\n'),
    transparent: true,
    depthWrite: false,
  });

  var points = new THREE.Points(geometry, pointsMaterial);
  points.rotation.x = -Math.PI / 2;
  scene.add(points);

  // Stars twinkle particles in sky above the mesh
  var starCount = 200;
  var starPositions = new Float32Array(starCount * 3);
  var starSizes = new Float32Array(starCount);
  var starOffsets = new Float32Array(starCount);

  for (var i = 0; i < starCount; i++) {
    starPositions[i * 3] = (Math.random() - 0.5) * 16;
    starPositions[i * 3 + 1] = Math.random() * 3 + 0.5;
    starPositions[i * 3 + 2] = -(Math.random() * 4 + 1);
    starSizes[i] = Math.random() * 2.0 + 0.5;
    starOffsets[i] = Math.random() * 6.28;
  }

  var starGeom = new THREE.BufferGeometry();
  starGeom.setAttribute('position', new THREE.BufferAttribute(starPositions, 3));
  starGeom.setAttribute('size', new THREE.BufferAttribute(starSizes, 1));
  starGeom.setAttribute('aOffset', new THREE.BufferAttribute(starOffsets, 1));

  var starsMaterial = new THREE.ShaderMaterial({
    uniforms: {
      time: { value: 0 },
      color: { value: new THREE.Color("#ffffff") },
    },
    vertexShader: [
      'attribute float size;',
      'attribute float aOffset;',
      'varying float vAlpha;',
      'uniform float time;',
      '',
      'void main() {',
      '    float twinkle = sin(time * 1.5 + aOffset * 6.28) * 0.3 + 0.7;',
      '    vAlpha = twinkle;',
      '    vec4 mvPosition = modelViewMatrix * vec4(position, 1.0);',
      '    gl_PointSize = size * (200.0 / -mvPosition.z);',
      '    gl_Position = projectionMatrix * mvPosition;',
      '}'
    ].join('\n'),
    fragmentShader: [
      'uniform vec3 color;',
      'varying float vAlpha;',
      '',
      'void main() {',
      '    vec2 uv = gl_PointCoord - vec2(0.5);',
      '    float d = length(uv);',
      '    if (d > 0.5) discard;',
      '    float alpha = smoothstep(0.5, 0.0, d) * vAlpha * 0.8;',
      '    gl_FragColor = vec4(color, alpha);',
      '}'
    ].join('\n'),
    transparent: true,
    depthWrite: false,
  });

  var stars = new THREE.Points(starGeom, starsMaterial);
  scene.add(stars);

  var frameId;
  var animate = function(t) {
    var timeVal = t * 0.001;
    material.uniforms.time.value = timeVal;
    pointsMaterial.uniforms.time.value = timeVal;
    starsMaterial.uniforms.time.value = timeVal;
    renderer.render(scene, camera);
    frameId = requestAnimationFrame(animate);
  };
  animate(0);

  var handleResize = function() {
    if (!container) return;
    camera.aspect = container.clientWidth / container.clientHeight;
    camera.updateProjectionMatrix();
    renderer.setSize(container.clientWidth, container.clientHeight);
  };

  var handleMouseMove = function(e) {
    var x = (e.clientX / window.innerWidth) * 2 - 1;
    var y = -(e.clientY / window.innerHeight) * 2 + 1;
    camera.position.x = x * 0.3;
    camera.position.y = 1.5 + y * 0.2;
    camera.lookAt(0, 0, 0);
  };

  window.addEventListener("resize", handleResize);
  window.addEventListener("mousemove", handleMouseMove);

    return {
    destroy: function() {
      cancelAnimationFrame(frameId);
      window.removeEventListener("resize", handleResize);
      window.removeEventListener("mousemove", handleMouseMove);
      if (container && renderer.domElement.parentNode === container) {
        container.removeChild(renderer.domElement);
      }
      geometry.dispose();
      material.dispose();
      pointsMaterial.dispose();
      starGeom.dispose();
      starsMaterial.dispose();
    }
  };
}
