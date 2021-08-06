(local cjson (require :cjson))

(fn empty-table? [t]
  (if t
    (= (next t) nil)
    true))

(fn VAL [config]
  (let [{: default} config]
    {:kind :VAL
     :default (or default cjson.null)}))

(fn OBJ [config]
  (let [{: of 
         : default} config]
    {:kind :OBJ
     :of of
     :default (or default {})}))

(fn ARR [config]
  (let [{: of 
         : default} config]
    {:kind :ARR
     :of of
     :default (or default cjson.empty_array)}))

(fn coerce [value schema]
  (match schema.kind
         :OBJ
         (let 
           [res {}]
           (each [k v (pairs schema.of)]
             (tset res k (coerce (. value k) v)))
           res)
         :VAL
         (or value schema.default)
         :ARR 
         (if (empty-table? value)
              schema.default
              (icollect [k v (pairs value)]
                (coerce v schema.of)))))

{: ARR
 : OBJ
 : VAL
 : coerce}
