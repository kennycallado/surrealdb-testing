CREATE questions CONTENT {
  type: 'input',
  question: [ {
    locale: 'vl',
    content: 'Com et diuen?'
  },{
    locale: 'es',
    content: '¿Cómo te llamas?'
  },{
    locale: 'en',
    content: 'what is your name?'
  } ]
}

-- error: only allowd ['vl', 'es', 'en']
-- UPDATE <id> CONTENT {
--   type: 'range',
--   question: [ {
--     locale: 'fr',
--     content: 'Quel est votre nom?'
--   },{
--     locale: 'de',
--     content: 'Wie heißen Sie?'
--   },{
--     locale: 'es',
--     content: '¿Cómo te llamas?'
--   } ]
-- }
