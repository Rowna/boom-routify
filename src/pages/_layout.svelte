<!-- 
    Das _layout bildet den "Rahmen", in den 
    die Components eingebaut werden. 
 -->
<script>
    import Header from "../components/Header.svelte";
    
</script>

<!-- 
    Header wird auf jeder Page eingefuegt,
    weil es "hart" im _layout eingefuegt wird.
 -->
<Header></Header>

<!-- 
    slot bezeichnet die Stelle, wo das 
    aktuelle page-component aus /pages eingefuegt wird. 

    <slot/> bedeutet: dass die Inhalt der aktuellen Page,
    die man aufruft, genau an dieser Stelle, wo <slot /> steht,
    eingefügt wird.

-->
<slot></slot>

