#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <locale.h>
#include <time.h>
#include <unistd.h>

int erro=0, VD=0, quadra=0, quina=0, sena=0, NUM_SORTEADOS=6, MAX_DEZENAS=15, MAX_CONCURSOS=8, h, acertos=0;

void *verifica_repeticoesQM(int **numeros, int qtd_dezenas, int i) {
    for (int k = 0; k < qtd_dezenas; k++) {
        for (int f = k + 1; f < qtd_dezenas; f++) {
            if (numeros[i][k] == numeros[i][f]) {
                printf("ERRO: O número %d foi digitado mais de uma vez.\n\n", numeros[i][k]);
                erro = 1;
                break;
            }
        }
    }
    return NULL;
}

void *verifica_repeticoes(int **numeros, int qtd_dezenas, int i) {
    for (int k = 0; k < qtd_dezenas; k++) {
        for (int f = k + 1; f < qtd_dezenas; f++) {
            if (numeros[i][k] == numeros[i][f]) {
                erro = 1;
                break;
            }
        }
    }
    return NULL;
}

void valor_VD(int qtd_dezenas) {
    if(qtd_dezenas == 6) {
        VD = 5;
    } else if(qtd_dezenas == 7) {
        VD = 35;
    } else if(qtd_dezenas == 8) {
        VD = 140;
    } else if(qtd_dezenas == 9) {
        VD = 420;
    } else if(qtd_dezenas == 10) {
        VD = 1050;
    } else if(qtd_dezenas == 11) {
        VD = 2310;
    } else if(qtd_dezenas == 12) {
        VD = 4620;
    } else if(qtd_dezenas == 13) {
        VD = 8580;
    } else if(qtd_dezenas == 14) {
        VD = 15015;
    } else if(qtd_dezenas == 15) {
        VD = 25025;
    }
}

void imprime_apostas(int **numeros, int QM, int **apostas, int QS, int qtd_dezenas) {
    printf("\n\nRevise suas apostas:\n");

    int h, y;
    for (h = 0; h < QM; h++) {
        printf("\nAposta %d (manual):\n", h + 1);
        for (int z = 0; z < qtd_dezenas; z++) {
            printf("%d ", numeros[h][z]);
        }
    }

    for (y = 0; y < QS; y++) {
        int soma = y + h;
        printf("\nAposta %d (surpresinha):\n", soma + 1);
        for (int x = 0; x < qtd_dezenas; x++) {
            printf("%d ", apostas[y][x]);
        }
    }
}

void contador_acertos(int **numeros, int QM, int qtd_dezenas, int **sorteados, int w, int NUM_SORTEADOS) {
    int z;
    for (h = 0; h < QM; h++) {
        acertos = 0;
        for (z = 0; z < qtd_dezenas; z++) {
            for (int s = 0; s < NUM_SORTEADOS; s++) {
                if (numeros[h][z] == sorteados[w][s]) {
                    acertos++;
                }
            }
        }

        printf("\nAposta %d: %d/6 acertos;", h + 1, acertos);
        if (acertos == 4) {
            printf(" QUADRA!");
            (quadra)++;
        }
        if (acertos == 5) {
            printf(" QUINA!");
            (quina)++;
        }
        if (acertos == 6) {
            printf(" SENA!");
            (sena)++;
        }
    }
}

void contador_acertos2(int **apostas, int QS, int qtd_dezenas, int **sorteados, int w, int NUM_SORTEADOS) {
    int b, z;
    for (b = 0; b < QS; b++) {
        acertos = 0;
        for (z = 0; z < qtd_dezenas; z++) {
            for (int s = 0; s < NUM_SORTEADOS; s++) {
                if (apostas[b][z] == sorteados[w][s]) {
                    acertos++;
                }
            }
        }

        printf("\nAposta %d: %d/6 acertos;", h + b + 1, acertos);
        if (acertos == 4) {
            printf(" QUADRA!");
            (quadra)++;
        }
        if (acertos == 5) {
            printf(" QUINA!");
            (quina)++;
        }
        if (acertos == 6) {
            printf(" SENA!");
            (sena)++;
        }
    }
}




int main() {
    setlocale(LC_ALL, "Portuguese");
    
 srand(time(NULL) + getpid());
 int qtd_dezenas, QM;
 int **numeros = NULL;

 do {
     
    printf("Digite quantas dezenas irá apostar (valores possíveis: 6 a 15): ");
    scanf("%d", &qtd_dezenas);
    
    if(qtd_dezenas < 6 || qtd_dezenas > 15) {
      printf("Número inválido. Ele deve estar entre 6 e 15.\n\n");
      continue;
    }
 
    printf("\nDigite quantas apostas manuais irá fazer (valores possíveis: 0 a 3): ");
    scanf("%d", &QM);
    getchar();
    
    if(QM < 0 || QM > 3) {
      printf("Número inválido. Ele deve estar entre 0 e 3.\n\n");
      continue;
    }
    
    if(QM == 0) {
      break;
    }
    
  numeros = (int **)malloc(QM * sizeof(int *));
    if (numeros == NULL) {
        printf("Erro de alocação de memória.\n");
        return 1;
    }
    
  int i, j, k, numero, palavras=0;
  char digitados[100];

        for(i=0; i<QM; i++) {
        
        printf("\nDigite a Aposta %d com %d dezenas (Números devem pertencer ao intervalo [01,60] e serem separados por espaço):\n", i+1, qtd_dezenas);
        fgets(digitados, sizeof(digitados), stdin);
        fflush(stdin);
        
    numeros[i] = (int *)malloc(qtd_dezenas * sizeof(int));
    if (numeros[i] == NULL) {
        printf("Erro de alocação de memória.\n");
        return 1;
    }
    
    int p = strlen(digitados);
    int aux = 0;
    
        for(j = 0; j < p; j++) {
       
         if(digitados[j] != ' ' && (digitados[j + 1] == ' ' || digitados[j + 1] == '\0')) {
            palavras++;
      }
    }    
         if(palavras != qtd_dezenas) {
           printf("Números inválidos. Eles devem estar de acordo com a quantidade de dezenas escolhida.\n\n");
           erro = 1;
           break;
         }
         
         palavras=0;
         char *token = strtok(digitados, " ");
         while(token) {
             int numero = atoi(token);
             
         if(numero < 1 || numero > 60) {
           printf("ERRO: O número %d é inválido, pois está fora do intervalo permitido (01 a 60).\n\n", numero);
           erro = 1;
           break;
         }
                numeros[i][aux++] = numero; 
                token = strtok(NULL, " ");
      }
         if(erro) {
             erro = 0;
             free(numeros[i]);
             break;
    }
         verifica_repeticoesQM(numeros, qtd_dezenas, i);

          if(erro) {
             erro = 0;
             free(numeros[i]);
             break;
    }
  }
        if(i == QM) {
            break;
        }
         
    } while(1);
       
    int QS;
    
    do {
       printf("\nDigite a quantidade de Surpresinhas que deseja apostar (valores possíveis: 0 a 7): ");
       scanf("%d", &QS);
       getchar();
       
       if(QS < 0 || QS > 7) {
      printf("Número inválido. Ele deve estar entre 0 e 7.");
      continue;
    }
       if(QS == 0 && QM == 0) {
         printf("\nObrigado por participar das Loterias Caixa.");
         return 0;
       }
    
       if(QS == 0 || QS > 0 && QS <= 7) {
         break;
    }
  } while(1);
    
    int QT;
    
    do {
     printf("\nDigite a quantidade de Teimosinhas (concursos que deseja participar com as mesmas apostas. Valores válidos: 1, 2, 4, 8): ");
     scanf("%d", &QT);
     getchar();
     
     if(QT != 1 && QT != 2 && QT != 4 && QT != 8) {
      printf("Número inválido. Ele deve ser 1, 2, 4, ou 8.");
      continue; 
     }
     
     if(QT == 1 || QT == 2 || QT == 4 || QT == 8) {
         break;
     }
   } while(1);
    
 int **apostas = NULL;
 
    apostas = (int **)malloc(QS * sizeof(int *));
    if (apostas == NULL) {
        printf("Erro de alocação de memória.\n");
        return 1;
    }
 
     if(QS > 0 && QS <= 7) {
         
    do {
        
    int q;
     
     for(q=0; q<QS; q++) {
        apostas[q] = (int *)malloc(qtd_dezenas * sizeof(int));
        if (apostas[q] == NULL) {
            printf("Erro de alocação de memória.\n");
            return 1;
        }
        
     for (int a = 0; a < qtd_dezenas; a++) {
         apostas[q][a] = rand() % 60 + 1;
    }

    verifica_repeticoes(apostas, qtd_dezenas, q);
    
        if(erro) {
             erro = 0;
             free(apostas[q]);
             break;
    }
  }
    if(q == QS) {
      break;
    }
  } while(1);
}
    valor_VD(qtd_dezenas);
       
    float valor_total = QT * (VD * (QM + QS));
    
    imprime_apostas(numeros, QM, apostas, QS, qtd_dezenas);

    printf("\n\nTeimosinhas: %d", QT);
    printf("\n\nValor total das apostas: R$ %.2f", valor_total);
    
    char resposta[2];
    
 do {
    printf("\nDeseja continuar(S/N)? ");
    fgets(resposta, sizeof(resposta), stdin);
    fflush(stdin);
    
    if(resposta[0] != 'S' && resposta[0] != 'N') {
      printf("\nERRO: A resposta deve ser S (sim), ou N (não).\n");
      continue;
    }
    
    if(resposta[0] == 'S' || resposta[0] == 'N') {
      break;
    }
 } while(1);
 
    if(resposta[0] == 'N') {
      printf("\nObrigado por participar das Loterias Caixa.");
      return 0;
    }
    
  int **sorteados = NULL;
  sorteados = (int **)malloc(MAX_CONCURSOS * sizeof(int *));
    if (sorteados == NULL) {
        printf("Erro de alocação de memória.\n");
        return 1;
    }
    
    if(resposta[0] == 'S') {
        
    int w, t, b, x, h, z, l, p, y, acertos=0;
    
  do {
      for(w = 0; w < QT; w++) {
      
      sorteados[w] = (int *)malloc(NUM_SORTEADOS * sizeof(int));
        if (sorteados[w] == NULL) {
            printf("Erro de alocação de memória.\n");
            return 1;
    }
        for (int p = 0; p < NUM_SORTEADOS; p++) {
         sorteados[w][p] = rand() % 60 + 1;
    }
        verifica_repeticoes(sorteados, NUM_SORTEADOS, w);

         if(erro) {
            erro=0;
            free(sorteados[w]);
            w--;
            continue;
  }
    printf("\n\nConcurso 000%d:\n\n", w + 1);
    printf("Dezenas sorteadas:\n");
    for (t = 0; t < NUM_SORTEADOS; t++) {
        printf("%d ", sorteados[w][t]);
  }
    contador_acertos(numeros, QM, qtd_dezenas, sorteados, w, NUM_SORTEADOS);
    
    contador_acertos2(apostas, QS, qtd_dezenas, sorteados, w, NUM_SORTEADOS);
}
     if(w==QT) {
        break;
    }
  } while(1);
  
  printf("\nTotal da aposta:\nR$ %.2f", valor_total);
   
 float valor_quadra = 834.93, valor_quina = 32797.02, valor_sena = 118265926.76, valor_ganho=0;
 
   if(quadra > 0 || quina > 0 || sena > 0) {
    
    if(qtd_dezenas == 6) {
      valor_ganho = (valor_sena*sena) + (valor_quina*quina) + (valor_quadra*quadra);
    }
    
    if(qtd_dezenas == 7) {
      valor_ganho = (valor_sena*sena) + (6*valor_quina*sena) + (2*valor_quina*quina) + (5*valor_quadra*quina) + (3*valor_quadra*quadra);
    }
    
    if(qtd_dezenas == 8) {
      valor_ganho = (valor_sena*sena) + (12*valor_quina*sena) + (15*valor_quadra*sena) + (3*valor_quina*quina) + (15*valor_quadra*quina) + (6*valor_quadra*quadra);
    }
    
    if(qtd_dezenas == 9) {
      valor_ganho = (valor_sena*sena) + (18*valor_quina*sena) + (45*valor_quadra*sena) + (4*valor_quina*quina) + (30*valor_quadra*quina) + (10*valor_quadra*quadra);
    }
    
    if(qtd_dezenas == 10) {
      valor_ganho = (valor_sena*sena) + (24*valor_quina*sena) + (90*valor_quadra*sena) + (5*valor_quina*quina) + (50*valor_quadra*quina) + (15*valor_quadra*quadra);
    }
    
    if(qtd_dezenas == 11) {
      valor_ganho = (valor_sena*sena) + (30*valor_quina*sena) + (150*valor_quadra*sena) + (6*valor_quina*quina) + (75*valor_quadra*quina) + (21*valor_quadra*quadra);
    }
    
    if(qtd_dezenas == 12) {
      valor_ganho = (valor_sena*sena) + (36*valor_quina*sena) + (225*valor_quadra*sena) + (7*valor_quina*quina) + (105*valor_quadra*quina) + (28*valor_quadra*quadra);
    }
    
    if(qtd_dezenas == 13) {
      valor_ganho = (valor_sena*sena) + (42*valor_quina*sena) + (315*valor_quadra*sena) + (8*valor_quina*quina) + (140*valor_quadra*quina) + (36*valor_quadra*quadra);
    }
    
    if(qtd_dezenas == 14) {
      valor_ganho = (valor_sena*sena) + (48*valor_quina*sena) + (420*valor_quadra*sena) + (9*valor_quina*quina) + (180*valor_quadra*quina) + (45*valor_quadra*quadra);
    }
    
    if(qtd_dezenas == 15) {
      valor_ganho = (valor_sena*sena) + (54*valor_quina*sena) + (540*valor_quadra*sena) + (10*valor_quina*quina) + (225*valor_quadra*quina) + (55*valor_quadra*quadra);
    }
 }
    printf("\nTotal dos prêmios:\nR$ %.2f", valor_ganho);
    printf("\nValor líquido:\nR$ %.2f", valor_ganho - valor_total);
    printf("\n\nObrigado por participar das Loterias Caixa!");
}
  free(numeros);
  free(apostas);
  free(sorteados);
     return 0;
}
