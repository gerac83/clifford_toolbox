function out = ReflectByHyper(h, x)

invH = GAvectorInverse(h);
out = GAproduct(h, x, invH);
out = -1 * out;

out = simplifyResult(out);