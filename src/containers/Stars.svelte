<script>

  
</script>

<p class="sternebewertung">

  <input type="radio" id="stern5" name="bewertung" value="5" /><label
    for="stern5"
    title="5 Sterne">5 Sterne</label
  >
  <input type="radio" id="stern4" name="bewertung" value="4" /><label
    for="stern4"
    title="4 Sterne">4 Sterne</label
  >
  <input type="radio" id="stern3" name="bewertung" value="3" /><label
    for="stern3"
    title="3 Sterne">3 Sterne</label
  >
  <input type="radio" id="stern2" name="bewertung" value="2" /><label
    for="stern2"
    title="2 Sterne">2 Sterne</label
  >
  <input type="radio" id="stern1" name="bewertung" value="1" /><label
    for="stern1"
    title="1 Stern">1 Stern</label
  >

  <span id="Bewertung" title="Keine Bewertung">
    <label>
      <input type="radio" name="bewertung" value="0" checked="checked" /> Cancel Rates
    </label>
  </span>

</p>

<style>
  /* Sternebewertung */
  span#Bewertung label {
    line-height: 45px;
    cursor: Pointer;
  }
  /* span#Bewertung input[type="radio"] { */
  /*display: None;*/
  /* } */
  p.sternebewertung {
    float: Left;
  }
  
  p.sternebewertung:not(:checked) > input {
    display: None;
  }

  p.sternebewertung:not(:checked) > label {
    float: Right;
    width: 1em;
    padding: 0 0.1em;
    overflow: Hidden;
    white-space: Nowrap;
    cursor: Pointer;
    font-size: 200%;
    line-height: 1.2;
    color: #d0d0d0;
    text-shadow: 1px 1px #b0b0b0, 2px 2px #606060,
      0.1em 0.1em 0.2em rgba(0, 0, 0, 0.5);
    transition: all 0.5s;
  }

  p.sternebewertung:not(:checked) > label::before {
    content: "★ ";
  }

  p.sternebewertung > input:checked ~ label {
    color: #ffd700;
    text-shadow: 1px 1px #c06000, 2px 2px #904000,
      0.1em 0.1em 0.2em rgba(0, 0, 0, 0.5);
    animation: twinkle 1s ease-in-out infinite alternate;
  }

  p.sternebewertung:not(:checked) > label:hover,
  p.sternebewertung:not(:checked) > label:hover ~ label {
    color: #fecf41;
    text-shadow: 1px 1px #f29e02, 2px 2px #b57340,
      0.1em 0.1em 0.2em rgba(0, 0, 0, 0.5);
  }

  p.sternebewertung > input:checked + label:hover,
  p.sternebewertung > input:checked + label:hover ~ label,
  p.sternebewertung > input:checked ~ label:hover,
  p.sternebewertung > input:checked ~ label:hover ~ label,
  p.sternebewertung > label:hover ~ input:checked ~ label {
    color: #fbb600;
    text-shadow: 1px 1px #f8ba01, 2px 2px #b57340,
      0.1em 0.1em 0.2em rgba(0, 0, 0, 0.5);
  }

  @keyframes twinkle {
    to {
      text-shadow: 1px 1px #ffe653, 2px 2px #fff5bf,
        0.1em 0.1em 0.2em rgba(0, 0, 0, 0.5);
    }
  }
</style>
