// implementação do algoritmo de bissecção

    //parametros: 
    //uma função f (pode ser qualquer função (seno, cosseno, x², x³))
    // o intervalo de a até b, onde geralmente a é o valor negativo e b positivo ou 0
    // prec é a precissão que queremos chegar
function algoritmo(f, a, b, prec) {

    // calculando um estimativa entre os dois pontos
    const est = (a+b) / 2;

    // se ja for preciso, então retornamos a estimativa
    if(Math.abs(b - a) < prec){
        return est;
    }

    // se f(est) = 0, então achamos uma raiz exata!
    if(f() == 0){
        return est;
    }

    // recursão: se o sinal deles for diferente, ou seja < 0, então
    if(f(est) * f(a) < 0){
        return algoritmo(f, a, est, prec);
    }
    else return algoritmo(f, est, b, prec);

}

console.log(algoritmo(x => x**3 - 3*x - 1, -1, 0, 1e-6));