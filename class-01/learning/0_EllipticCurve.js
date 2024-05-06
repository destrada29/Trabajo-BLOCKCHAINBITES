/**
 * Read the file class-01/learning/EllipticCurve.md and implement the
 * algorithm in javascript
 *
 * Build an Elliptic Curve that does:
 * - Point Addition
 * - Scalar Multiplication
 *
 * To verify your Elliptic Curve use the following values:
 *
 * y^2 = x^3 - 3*x + 4 (mod 17)
 *
 * Point A = (1, 6)
 * Point B = (9, 14)
 *
 * Point Addition:
 * Point A + Point B = (8, 4)
 *
 * Scalar Multiplication:
 * Point A * 4 = (12, 8)
 *
 * You need to use this file to solve the exercise exercise/keyExchangeProtocol.js
 */
class Point {
  constructor(x, y) {
    this.x = x;
    this.y = y;
  }
}

var A = new Point(1, 6);
var B = new Point(9, 14);

class ECC {
  constructor(a, b, p) {
    this.a = a;
    this.b = b;
    this.p = p;
  }

  pointAddition(P, Q) {
    if (P === null) return Q;
    if (Q === null) return P;

    if (P.x === Q.x && P.y === (-Q.y + this.p) % this.p) return null;

    let lamda;
    if (P.x === Q.x && P.y === Q.y) {
      lamda = (3 * P.x * P.x + this.a) * this.modInverse(2 * P.y, this.p);
    } else {
      lamda = (Q.y - P.y) * this.modInverse(Q.x - P.x + this.p, this.p);
    }

    let x3 = (lamda * lamda - P.x - Q.x + this.p) % this.p;
    let y3 = (lamda * (P.x - x3) - P.y + this.p) % this.p;
    if (y3 < 0) {
      y3 += this.p;
    }

    return new Point(x3, y3);
  }

  scalarMultiplication(n, P) {
    let Q = null;
    let R = P;

    while (n > 0) {
      if (n % 2 === 1) {
        Q = this.pointAddition(Q, R);
      }
      R = this.pointAddition(R, R);
      n = Math.floor(n / 2);
    }

    return Q;
  }

  modInverse(a, m) {
    a = ((a % m) + m) % m;
    for (let x = 1; x < m; x++) {
      if ((a * x) % m == 1) {
        return x;
      }
    }
    return 1;
  }
}

var ecc = new ECC(-3, 4, 17); // y^2 = x^3 - 3x + 4 (mod 17)
var resultAddition = ecc.pointAddition(A, B);
console.log("Point Addition:", resultAddition);

var resultMultiplication = ecc.scalarMultiplication(4, A);
console.log("Scalar Multiplication:", resultMultiplication);

module.exports = { ECC };











