use dep::std;
global MAX: Fraction = Fraction { sign: true, num: 4294967295, den: 1 };
global MIN: Fraction = Fraction { sign: false, num: 4294967295, den: 1 };
global ZERO: Fraction = Fraction { sign: true, num: 0, den: 1 };
global ONE: Fraction = Fraction { sign: true, num: 1, den: 1 };
global NEGATIVE_ONE: Fraction = Fraction { sign: false, num: 1, den: 1 };

struct Fraction {
    sign: bool,
    num: u32,
    den: u32,
}


// Create a Fraction type variable without lenghtier code
fn toFraction(s: bool, n: u32, d: u32) -> Fraction {
    assert (d != 0);
    let fr = Fraction {
        sign: s,
        num: n,
        den: d,
    };
    fr
}


// Swaps the numerator and denominator
fn invertFraction(f: Fraction) -> Fraction {
    assert (f.num != 0);
    let fr = Fraction {
        sign: f.sign,
        num: f.den,
        den: f.num,
    };
    fr
}


// Multiplies two fractions
fn multiplyFraction(f1: Fraction, f2: Fraction) -> Fraction {
    let fr = Fraction {
        sign: (f1.sign == f2.sign),
        num: f1.num*f2.num,
        den: f1.den*f2.den,
    };
    fr
}


// Divides the first fraction by the second
fn divideFraction(f1: Fraction, f2: Fraction) -> Fraction {
    assert (f2.num != 0);
    let fr = Fraction {
        sign: (f1.sign == f2.sign),
        num: f1.num*f2.den,
        den: f1.den*f2.num,
    };
    fr
}

// this method will only work till numerator and denominator values are under 100
// this has been set for efficiency reasons, and will be modified once the Noir team
// can implement dynamic limit for loops
fn reduceFraction(f: Fraction) -> Fraction {
    let mut a = f.num;
    let mut b = f.den;
    let mut min = 0;
    let mut j = 1;
    let mut gcd = 1;
    if a > b {
        min = b;
    }
    else {
        min = a;
    }
    
    for i in 2..100{
        j = i as u32;
        if (j <= min){
            if (a%j == 0) & (b%j == 0){
                gcd = j;
            }
        }
    }
    
    
    let fr = Fraction {
        sign: f.sign,
        num: f.num/gcd,
        den: f.den/gcd,
    };
    fr
}


// Adds two fractions
fn addFraction(f1: Fraction, f2: Fraction) -> Fraction {
    if f1.sign == f2.sign {
        let fr = Fraction {
            sign: f1.sign,
            num: (f1.num*f2.den + f2.num*f1.den),
            den: f1.den*f2.den,
        };
        fr
    }
    else {
        if ((f1.num*f2.den) > (f2.num*f1.den)){
            let fr = Fraction {
                sign: f1.sign,
                num: (f1.num*f2.den-f2.num*f1.den),
                den: f1.den*f2.den,
            };
            fr
        }
        else {
            let fr = Fraction {
                sign: f2.sign,
                num: (f2.num*f1.den-f1.num*f2.den),
                den: f1.den*f2.den,
            };
            fr
        }
    }
}


// Subtract the second fraction from the first
fn subtractFraction(f1: Fraction, f2: Fraction) -> Fraction {
    if f1.sign != f2.sign {
        let fr = Fraction {
            sign: f1.sign,
            num: (f1.num*f2.den + f2.num*f1.den),
            den: f1.den*f2.den,
        };
        fr
    }
    else {
        if ((f1.num*f2.den) > (f2.num*f1.den)){
            let fr = Fraction {
                sign: f1.sign,
                num: (f1.num*f2.den - f2.num*f1.den),
                den: f1.den*f2.den,
            };
            
            fr
        }
        else {
            let fr = Fraction {
                sign: f2.sign,
                num: (f2.num*f1.den - f1.num*f2.den),
                den: f1.den*f2.den,
            };
            
            fr
        }
    }
}


// if a > b return 1
// if a < b return 2
// if a == b return 0
fn compareFraction(f1: Fraction, f2: Fraction) -> u32 {
    if ((f1.num == f2.num) & (f1.num == 0)){
        0
    }
    else {
        if (f1.sign != f2.sign){
            if (f1.sign){
                1
            }
            else {
                2
            }
        }
        else {
            
            if ((f1.num*f2.den) > (f2.num*f1.den)){
                if (f1.sign){
                    1
                }
                else {
                    2
                }
            }
            else {
                
                if ((f1.num*f2.den) != (f2.num*f1.den)){
                    if (f1.sign){
                        2
                    }
                    else {
                        1
                    }
                }
                else {
                    0
                }
                
            }
            
        }
    }
    
}


// Multiplies a fraction by itself
fn squareFraction(f: Fraction) -> Fraction {
    let fr = Fraction {
        sign: true,
        num: f.num*f.num,
        den: f.den*f.den,
    };
    fr
}


// Multiplies a fraction by itself, then again by itself
fn cubeFraction(f: Fraction) -> Fraction {
    let fr = Fraction {
        sign: f.sign,
        num: f.num*f.num*f.num,
        den: f.den*f.den*f.den,
    };
    fr
}


// Adds 1 to the fraction
fn incrFraction(f: Fraction) -> Fraction {
    let inc = Fraction {
        sign: true,
        num: 1,
        den: 1,
    };
    let fr = addFraction(f, inc);
    fr
}


// Subtracts 1 from the fraction
fn decrFraction(f: Fraction) -> Fraction {
    let dec = Fraction {
        sign: true,
        num: 1,
        den: 1,
    };
    let fr = subtractFraction(f, dec);
    fr
}


// Returns true if the fraction can be represented as an Integer
fn isInteger(f: Fraction) -> bool {
    if f.num == 0 {
        true
    }
    else {
        if (f.num % f.den == 0) {
            true
        }
        else {
            false
        }
    }
    
}


// Returns true if the fraction can NOT be represented as an Integer
fn isNotInteger(f: Fraction) -> bool {
    if f.num == 0 {
        false
    }
    else {
        if (f.num % f.den == 0) {
            false
        }
        else {
            true
        }
    }
    
}


// Returns the closest but smaller Integer to the Given Fraction, but typecast to Fraction for convenience
fn floor(f: Fraction) -> Fraction {
    let q = f.num/f.den;
    if (q * f.den == f.num){
        let fr = Fraction{
            sign: f.sign,
            num: f.num,
            den: f.den,
        };
        fr
    }
    else {
        if f.sign {
            let fr = Fraction{
                sign: f.sign,
                num: q,
                den: 1,
            };
            fr    
        }
        else {
            let fr = Fraction{
                sign: f.sign,
                num: q + 1,
                den: 1,
            };
            fr 
        }
        
    }
}

// Returns the closest but greater Integer to the Given Fraction, but typecast to Fraction for convenience
fn ceiling(f: Fraction) -> Fraction {
    let q = f.num/f.den;
    if (q * f.den == f.num){
        let fr = Fraction{
            sign: f.sign,
            num: f.num,
            den: f.den,
        };
        fr
    }
    else {
        if f.sign {
            let fr = Fraction{
                sign: f.sign,
                num: q + 1,
                den: 1,
            };
            fr    
        }
        else {
            let fr = Fraction{
                sign: f.sign,
                num: q,
                den: 1,
            };
            fr 
        }
        
    }
}

#[test]
fn test_sum() {
    let f1 = toFraction(true, 3, 5);
    let f2 = toFraction(true, 2, 5);
    let f = addFraction(f1, f2);
    assert (f.num == f.den);
}

#[test]
fn test_sum_negative() {
    let f1 = toFraction(true, 3, 5);
    let f2 = toFraction(false, 1, 5);
    let f = addFraction(f1, f2);
    let cmp = compareFraction(f, toFraction(true, 2,5));
    assert (cmp == 0);
    
}

#[test]
fn test_diff() {
    let f1 = toFraction(true, 3, 5);
    let f2 = toFraction(true, 2, 5);
    let f = subtractFraction(f1, f2);
    let cmp = compareFraction(f, toFraction(true, 1,5));
    assert (cmp == 0);
    
}

#[test]
fn test_mul() {
    let f1 = toFraction(true, 1, 5);
    let f2 = toFraction(true, 5, 1);
    let f = multiplyFraction(f1, f2);
    assert (f.num == f.den);
}

#[test]
fn test_inv() {
    let f1 = toFraction(false, 1, 5);
    let f2 = invertFraction(f1);
    let f = multiplyFraction(f1, f2);
    assert (f.num == f.den);
    
}


#[test]
fn test_div() {
    let f1 = toFraction(true, 6, 5);
    let f2 = toFraction(true, 5, 1);
    let f = divideFraction(f1, f2);
    assert (f.num == 6);
    assert (f.den == 25);
}

#[test]
fn test_not_integer() {
    let f1 = toFraction(false, 1, 5);
    
    let is_int = isInteger(f1);

    assert (!is_int);
    
}

#[test]
fn test_integer() {
    let f1 = toFraction(false, 10, 5);
    
    let is_int = isInteger(f1);

    assert (is_int);
    
}

#[test]
fn test_square() {
    let f1 = toFraction(true, 4, 5);
    
    let f = squareFraction(f1);

    assert (f.num == 16);
    
}

#[test]
fn test_cube() {
    let f1 = toFraction(false, 1, 5);
    
    let f = cubeFraction(f1);

    assert (f.num == 1);
    assert (f.den == 125);
    assert (!f.sign);
    
}

#[test]
fn test_compare() {
    let f1 = toFraction(true, 4, 5);
    let f2 = toFraction(true, 8, 10);
    let cmp = compareFraction(f1, f2);

    assert (cmp == 0);
    
}


#[test]
fn test_reduce() {
    let f1 = toFraction(true, 2, 10);
    let f2 = reduceFraction(f1);

    assert (f2.num == 1);
    
}

#[test]
fn test_zero_neutrality() {
    let f1 = toFraction(true, 0, 5);
    let f2 = toFraction(false, 0, 10);
    let cmp = compareFraction(f1, f2);

    assert (cmp == 0);
    
}

#[test]
fn test_floor() {
    let f = toFraction(true, 7, 5);
    let fl = floor(f);
    assert (fl.num == 1);
    assert (fl.den == 1);
}

#[test]
fn test_floor2() {
    let f = toFraction(false, 12, 5);
    let fl = floor(f);
    assert (fl.num == 3);
    assert (fl.den == 1);
}


#[test]
fn test_ceiling() {
    let f = toFraction(true, 7, 5);
    let ce = ceiling(f);
    assert (ce.num == 2);
    assert (ce.den == 1);
}

#[test]
fn test_ceiling2() {
    let f = toFraction(false, 12, 5);
    let ce = ceiling(f);
    assert (ce.num == 2);
    assert (ce.den == 1);
}