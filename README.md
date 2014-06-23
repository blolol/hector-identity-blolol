### hector-identity-blolol

hector-identity-blolol is a
[Hector](https://github.com/sstephenson/hector) identity adapter for
[Blolol.com](https://blolol.com).

### Usage

In your Hector configuration, load hector-identity-blolol and use it as Hector's identity adapter.

```ruby
require 'blolol/hector/identity_adapter'

Hector::Identity.adapter = Blolol::Hector::IdentityAdapter.new(auth_token: '...')
```

By default, hector-identity-blolol makes requests to
`https://blolol.com`, but you can also specify a different base URL.

```ruby
Blolol::Hector::IdentityAdapter.new(auth_token: '...', base_url: 'https://staging.example.com')
```

### License

(The MIT license)

Copyright (c) 2014 Ross Paffett

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
"Software"), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
