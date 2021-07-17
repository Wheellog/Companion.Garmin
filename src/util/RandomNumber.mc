import Toybox.Math;

// return a random value on the range [n, m] 
function random(n, m) { 
    return m + Math.rand() / (0x7FFFFFF / (n - m + 1) + 1); 
} 