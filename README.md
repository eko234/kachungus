# KACHUNGUS

This is a tool for coercing lua values to a json schema helping you keep data consistency, thats it.
the idea is to improve it further, but it is not my priority for now, it solves a use case for me
which is keeping data integrity while building json rest apis with the awesome lapis framework.

It only depends on cjson but if you want to change how to represent values, then the "library" is quite
simple so go ahead and hack it.

## USE

first we define a schema:

``` fennel
(local my-schema
  (OBJ 
   {:of 
    {:name (VAL {})
     :list (ARR 
            {:of 
             (OBJ 
              {:of 
               {:number (VAL {})}})})}}))
```

kachungus provides three basic constructs for defining a schema:
  - VAL : is any value that proven nil will default to cjson.null
  - ARR : is a table that proven empty or nil will default to cjson.empty_array
  - OBJ : is a table that proven empty or nil will default to an empty table


now lets suppose we habe a table like this:

``` fennel
(local my-table
  {:name "luis"
   :list [{:number 1} {:number 2}]})
```

if we call:

``` fennel
(coerce my-table my-schema)
```

we will get:


``` fennel
{:list [{:number 1} {:number 2}] :name "luis"}
```

if we call:

``` fennel
(coerce {} my-schema)
```

we will get:
``` fennel
{:list <cjson_empty_array> :name <cjson_null>}
```
