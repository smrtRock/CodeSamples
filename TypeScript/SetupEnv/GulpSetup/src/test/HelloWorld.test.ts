import { should } from 'chai';
import { HelloWorld } from '../app/HelloWorld';
should();

describe('Hello World test suite', function() {
    it('Can say Hello world', function() {
        const result = new HelloWorld().helloWorld();
        result.should.equals('Hello World', 'Should return: Hello World, but returned $result');
    });
});