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

fn toFraction(s: bool, n: u32, d: u32) -> Fraction {
    constrain d != 0;
    let fr = Fraction {
        sign: s,
        num: n,
        den: d,
    };
    fr
}



fn invertFraction(f: Fraction) -> Fraction {
    constrain f.den != 0;
    let fr = Fraction {
        sign: f.sign,
        num: f.den,
        den: f.num,
    };
    fr
}

fn multiplyFraction(f1: Fraction, f2: Fraction) -> Fraction {
    let fr = Fraction {
        sign: (f1.sign == f2.sign),
        num: f1.num*f2.num,
        den: f1.den*f2.den,
    };
    fr
}

fn divideFraction(f1: Fraction, f2: Fraction) -> Fraction {
    constrain f2.num != 0;
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
    if (f1.sign != f2.sign){
        if (f1.sign){
            1
        }
        else {
            2
        }
    }
    else {
        
        if ((f1.num*f2.den) > (f2.num*f2.den)){
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

fn squareFraction(f: Fraction) -> Fraction {
    let fr = Fraction {
        sign: true,
        num: f.num*f.num,
        den: f.den*f.den,
    };
    fr
}

fn cubeFraction(f: Fraction) -> Fraction {
    let fr = Fraction {
        sign: f.sign,
        num: f.num*f.num*f.num,
        den: f.den*f.den*f.den,
    };
    fr
}

fn incrFraction(f: Fraction) -> Fraction {
    let inc = Fraction {
        sign: true,
        num: 1,
        den: 1,
    };
    let fr = addFraction(f, inc);
    fr
}

fn decrFraction(f: Fraction) -> Fraction {
    let dec = Fraction {
        sign: true,
        num: 1,
        den: 1,
    };
    let fr = subtractFraction(f, dec);
    fr
}