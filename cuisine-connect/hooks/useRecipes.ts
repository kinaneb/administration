import {useEffect, useState} from "react";


async function fetchData() {
    const recipes = await fetch('/api/recipes');

}
export function useRecipes() {
    const [recipes, setRecipes] = useState([{id: '', name: '', thumbnailUrl: ''}]);

    useEffect(() => {
        (async () => {
            await fetch('/api/recipes')
                .then((response) => response.json())
                .then((data) => setRecipes(data.recipes))
        })();
    }, [])

    return recipes;
}
