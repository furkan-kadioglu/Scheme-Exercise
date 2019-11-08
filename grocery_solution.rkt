#lang scheme

(define FARMS '(
(farmA 100 (apricot apple blueberry)) (farmB 90 (broccoli carrot grape))
(farmC 75 (corn grape lemon))
(farmD 75 ())
(farmE 45 (lemon melon olive berry))
(farmF 70 (lemon carrot))
(farmG 50 (olive))
(farmH 150 (olive grape apple))
(farmI 50 (apple))
(farmJ 45 (ginger beans garlic))
(farmK 70 (spinach onion peas))
(farmL 50 ())
(farmM 150 (spinach melon potato tomato)) (farmN 50 (spinach corn))
(farmO 50 (spinach))
))
(define CUSTOMERS '(
(john (farmA farmC) (apricot lemon))
(james (farmB farmC) (grape corn))
(arya (farmB farmD) (grape broccoli))
(elenor () ())
(alan (farmG farmH) (olive apple))
(george (farmF farmE farmG) (lemon melon olive apple))
(cersei (farmE farmF farmH farmI) (lemon olive apple))
(jon (farmA farmB farmC farmD farmE farmF farmG farmH farmI) (apricot apple blueberry broccoli carrot grape corn lemon melon olive berry))
(sophia (farmK farmN farmO) (spinach onion corn))
(liam (farmM farmN farmO) (spinach melon potato))
(emma (farmD farmH farmK farmA) (apricot grape spinach))
(river (farmG farmB farmI farmA) (apple broccoli olive))
(lucas (farmK farmJ farmA farmD farmM farmN) (spinach onion apple))
(oliver (farmE farmF farmG) (lemon olive))
(zoe () ())
))
(define CROPS '( (apricot farmA 10) (apple farmA 12) (melon farmE 22) (olive farmE 40) (berry farmE 10) (lemon farmF 35) (carrot farmF 5) (olive farmG 60) (olive farmH 30) (blueberry farmA 15) (broccoli farmB 8) (carrot farmB 5) (grape farmB 10) (corn farmC 9) (grape farmC 12) (lemon farmC 10)
(lemon farmE 12) (grape farmH 10) (apple farmH 8) (apple farmI 8) (ginger farmJ 10) (beans farmJ 13) (garlic farmJ 15) (spinach farmK 5) (onion farmK 9) (peas farmK 8) (spinach farmM 10) (melon farmM 15) (potato farmM 9) (tomato farmM 9) (spinach farmN 7) (corn farmN 9) (spinach farmO 6) ))

;2015400051

#|
***********BASIC FUNCTIONS**********
They help operations for simple design.
|#

#|BASIC FUNCTION **1**
returns whether X in Y or not
|#
(define (include? x y)(
    cond 
    ((null? y) #f)
    (else (or (equal? x (car y)) (include? x (cdr y))))
))

#|BASIC FUNCTION **2**
returns the list of Y's members contain X
|#
(define (extended_filter x y)(
    filter (curry include? x)
    y
))

#|BASIC FUNCTION **3**
returns whether X in Y's second item or not
|#
(define (sub_include_2? x y)(
    cond
    ((null? (cadr y)) #f)
    (else (include? x (cadr y)))
))

#|BASIC FUNCTION **4**
returns the list of Y's members' second items contain X
|#
(define (extended_filter_2 x y)(
    filter (curry sub_include_2? x)
    y
))

#|BASIC FUNCTION **5**
returns the first elements of Y's members
|#
(define (get_firsts y)(
    cond
    ((null? y) '())
    (else (cons (caar y) (get_firsts (cdr y))))
))

#|BASIC FUNCTION **6**
returns whether X in Y's third item or not
|#
(define (sub_include_3? x y)(
    cond
    ((null? (caddr y)) #f)
    (else (include? x (caddr y)))
))

#|BASIC FUNCTION **7**
returns the list of Y's members' third items contain X
|#
(define (extended_filter_3 x y)(
    filter (curry sub_include_3? x)
    y
))

#|BASIC FUNCTION **8**
returns the thirds elements of Y's members
|#
(define (get_thirds y)(
    cond
    ((null? y) '())
    (else (cons (caddar y) (get_thirds (cdr y))))
))

#|BASIC FUNCTION **9**
Compares num with Y's third item by using func
|#
(define (comparator_3 func num y)(
    cond
    ((null? y) #f)
    (else (func num (caddr y)))
))

#|BASIC FUNCTION **10**
Filters Y by using comparator_3
|#
(define (comparator_filter_3 func num y)(
    cond
    ((null? y) '())
    (else (filter (curry comparator_3 func num) y))
))

#|BASIC FUNCTION **11**
Removes duplicates from Y
|#
(define (remove_duplicates y)(
    cond
    ((null? y) '())
    ((include? (car y) (cdr y)) (remove_duplicates (cdr y)))
    (else (cons (car y) (remove_duplicates (cdr y))))
))

#|BASIC FUNCTION **12**
Returns last item in the member of Z has X and Y
|#
(define (get_last_item x y z)(
    cond
    ((null? z) 0)
    ((and (equal? x (caar z)) (equal? y (cadar z))) (caddar z))
    (else (get_last_item x y (cdr z)))
))

#|BASIC FUNCTION **13**
Returns first non zero element of Y
|#
(define (get_non_zero y)(
    cond
    ((null? y) 0)
    ((null? (cdr y)) (car y))
    ((equal? 0 (car y)) (cadr y))
    (else (car y))
))

#|
*********OPERATIONS*********
|#

;-------SIMPLE QUERIES-------

;SIMPLE QUERY **1**
(define (TRANSPORTATION-COST farm)(
    cond
    ((null? (extended_filter farm FARMS)) 0)
    (else (cadar(extended_filter farm FARMS)))
))

;SIMPLE QUERY **2**
(define (AVAILABLE-CROPS farm)(
    cond
    ((null? (extended_filter farm FARMS)) '())
    (else (caddar(extended_filter farm FARMS)))
))

;SIMPLE QUERY **3**
(define (INTERESTED-CROPS customer)(
    cond
    ((null? (extended_filter customer CUSTOMERS)) '())
    (else (caddar(extended_filter customer CUSTOMERS)))
))

;SIMPLE QUERY **4**
(define (CONTRACT-FARMS customer)(
    cond
    ((null? (extended_filter customer CUSTOMERS)) '())
    (else (cadar(extended_filter customer CUSTOMERS)))
))

;-------CONSTRUCTING LISTS-------

;CONSTRUCTING LIST **1**
(define (CONTRACT-WITH-FARM farm)(
    get_firsts(extended_filter_2 farm CUSTOMERS)
))

;CONSTRUCTING LIST **2**
(define (INTERESTED-IN-CROP crop)(
    get_firsts (extended_filter_3 crop CUSTOMERS)
))

;-------SHOPPING PRICES-------

;SHOPPING PRICES **1**
(define (MIN-SALE-PRICE crop)(
    cond
    ((null? (sort(get_thirds (extended_filter crop CROPS)) < )) 0)
    (else (car (sort(get_thirds (extended_filter crop CROPS)) < )))
))

;SHOPPING PRICES **2**
(define (CROPS-BETWEEN min max)(
    remove_duplicates(
        get_firsts 
        (
            comparator_filter_3 >= max 
            (
                comparator_filter_3 <= min CROPS
            )
        )
    )
))

;SHOPPING PRICES **3**
;Returns price value in CROPS
(define (get_price crop farm)(
    cond
    ((equal? 0 (get_last_item crop farm CROPS)) 0)
    (else (+(TRANSPORTATION-COST farm)(get_last_item crop farm CROPS)))
))
(define (get_price_list crop farm_list)(
    cond
    ((null? farm_list) '())
    (else (cons (get_price crop (car farm_list)) (get_price_list crop (cdr farm_list))))
))
(define (BUY-PRICE customer crop)(
    get_non_zero (sort (get_price_list crop (CONTRACT-FARMS customer)) <)
))

;SHOPPING PRICES **4**
(define (get_crop_price_list customer crop_list)(
    cond
    ((null? crop_list) '())
    (else (cons (BUY-PRICE customer (car crop_list))(get_crop_price_list customer (cdr crop_list))))
))
(define (TOTAL-PRICE customer)(
    foldr + 0 (get_crop_price_list customer (INTERESTED-CROPS customer))
))

;(min-sale-price 'grape)
;(BUY-PRICE 'jon 'apple)
;(BUY-PRICE 'river 'apple)
;(TOTAL-PRICE 'jon)
(TOTAL-PRICE 'zoe)
