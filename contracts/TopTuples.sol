// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract TopTules {
    uint256[] firstElements;
    uint256[] secondElements;
    uint256 totalLength;
    uint256 minIndex;

    constructor(uint256 _N) {
        totalLength = _N;
    }

    function add(uint256 x, uint256 y) public {
        require(x >= 0 && y >= 0 , "Elements are 0 or positive integers");
        uint256 tempLength = firstElements.length;
        if(tempLength < totalLength) {
            firstElements.push(x);
            secondElements.push(y);
            
            if(firstElements[minIndex] > x) {
                minIndex = tempLength;
            } else if (firstElements[minIndex] == x && secondElements[minIndex] > y) {
                minIndex = tempLength;
            }
            
        } else {
            if(firstElements[minIndex] > x){
                return;
            } else if (firstElements[minIndex] == x && secondElements[minIndex] > y) {
                return;
            }
            firstElements[minIndex] = x;
            secondElements[minIndex] = y;
            _updateMinIndex();
        }
    }

    function _updateMinIndex() internal {
        for(uint256 i = 0; i < firstElements.length; i ++) {
            if(firstElements[minIndex] > firstElements[i]) {
                minIndex = i;
            } else if (firstElements[minIndex] == firstElements[i] && secondElements[minIndex] > secondElements[i]) {
                minIndex = i;
            }
        }
    }

    function getTop(uint256 index) public view returns (uint256, uint256) {
        // Returns one of the top tuples. index should satisfy 0 <= index < N.
        // Top tuples needs not be ordred.
        require(index < totalLength, "index should satisfy 0 <= index < N");
        uint256 _limitIndex = totalLength;
        for(uint256 i = 0; i < index ; i ++) {
            _limitIndex = _getMaxIndex(_limitIndex);
        }
        return (firstElements[_limitIndex], secondElements[_limitIndex]);
    }

    function _getMaxIndex(uint256 _limitIndex) internal view returns (uint256) {
        uint256 maxIndex = 0;
        for(uint256 i = 1; i < firstElements.length; i ++) {
            if(_compare(i, maxIndex) && ((!_compare(i, _limitIndex) && i != _limitIndex) || _limitIndex >= totalLength)){
                maxIndex = i;
            }
        }
        return maxIndex;
    }

    function _compare(uint256 _indexA, uint256 _indexB) internal view returns (bool) {
        if(firstElements[_indexA] > firstElements[_indexB]) {
            return true;
        } else if (firstElements[_indexA] == firstElements[_indexB] && secondElements[_indexA] > secondElements[_indexB]) {
            return true;
        }
        return false;
    }
}
