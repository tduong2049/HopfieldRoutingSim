function w2 = connectionWeight2(s, d, u, i, j, k, l)
  w2 = -u(6)*kroneckerDelta(i, k) - u(7)*kroneckerDelta(j, l);